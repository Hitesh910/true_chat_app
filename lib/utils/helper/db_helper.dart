import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screen/chat/model/chat_model.dart';
import '../../screen/profile/model/profile_model.dart';
import 'auth_helper.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? docId;

  Future<void> setProfile(ProfileModel m1) async {
    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": m1.name,
      "email": m1.email,
      "bio": m1.bio,
      "mobile": m1.mobile,
      "uid": AuthHelper.helper.user!.uid,
    });
  }

  Future<ProfileModel?> getProfile() async {
    DocumentSnapshot docData = await fireStore
        .collection('User')
        .doc(AuthHelper.helper.user!.uid)
        .get();

    if (docData.exists) {
      Map m1 = docData.data() as Map;
      ProfileModel model = ProfileModel.mapToModel(m1);
      return model;
    } else {
      return null;
    }
  }

  Future<List<ProfileModel>> getUser() async {
    List<ProfileModel> profileList = [];
    QuerySnapshot snapshot = await fireStore
        .collection('User')
        .where('uid', isNotEqualTo: AuthHelper.helper.user!.uid)
        .get();
    List<QueryDocumentSnapshot> docList = snapshot.docs;

    for (var x in docList) {
      Map m1 = x.data() as Map;
      ProfileModel model = ProfileModel.mapToModel(m1);
      String uid = x.id;

      model.uid = uid;
      profileList.add(model);
    }
    return profileList;
  }

  void sentMsg(String senderUID, String receiverUID,ChatModel model) async {
    String? id = await checkConeverSation(senderUID, receiverUID);

    if (id == null) {
      DocumentReference reference = await fireStore.collection('Chat').add({
        "uids": [senderUID, receiverUID]
      });
      id = reference.id;
    }
    await fireStore.collection('Chat').doc(id).collection('msg').add(
      {
        "msg": model.msg,
        "date": model.dateTime,
        "sendUID": model.senderUID,
      },
    );
  }

  Future<String?> checkConeverSation(
      String senderUID, String receiverUID) async {
    QuerySnapshot snapshot = await fireStore
        .collection('Chat')
        .where("uids", isEqualTo: [senderUID, receiverUID]).get();
    List<DocumentSnapshot> l1 = snapshot.docs;

    if (l1.isEmpty) {
      QuerySnapshot snapshot = await fireStore
          .collection('Chat')
          .where("uids", arrayContains: [receiverUID, senderUID]).get();
      List<DocumentSnapshot> l2 = snapshot.docs;

      if (l2.isEmpty) {
        return null;
      } else {
        DocumentSnapshot ds2 = l2[0];
        return ds2.id;
      }
    } else {
      DocumentSnapshot sp = l1[0];
      return sp.id;
    }
  }

  Future<void> getDocDataId(String senderUID,String receiverUID)
  async {
    docId = await checkConeverSation(senderUID, receiverUID);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getReadData()
  {
    return fireStore.collection("Chat").doc(docId).collection("msg").snapshots();
  }

  Future<void> deleteData()
  async {
    await fireStore.collection("Chat").doc(docId).collection("msg").doc(docId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat() {
    return fireStore.collection("Chat").where("uids",arrayContains: AuthHelper.helper.user!.uid).snapshots();
  }

  Future<ProfileModel> userChat(String receiverID) async {
    DocumentSnapshot snapshot = await fireStore.collection("User").doc(receiverID).get();
    Map m1=snapshot.data()as Map;
    ProfileModel userChatList = ProfileModel.mapToModel(m1);

    return userChatList;
  }
}
