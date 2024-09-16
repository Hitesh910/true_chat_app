import 'package:firebase_messaging/firebase_messaging.dart';

import '../services/notification_services.dart';

class FcmHelper {
  static FcmHelper helper = FcmHelper._();

  FcmHelper._();

  String? token;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initiliaze() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> getToken()
  async {
    token =await FirebaseMessaging.instance.getToken();
  }

  void receiveData()
  {
    getToken();
    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification != null) {
        String? title = event.notification!.title;
        String? body = event.notification!.body;
        String? image = event.notification!.android!.imageUrl;

        if(title != null && body != null && image == null)
          {
           NotificationServices.notificationServices.showSimpleNotification(title,body);
          }
        else if(title != null && body != null && image != null)
          {
            NotificationServices.notificationServices.showBigImage(title, body, image);
          }
     }
    },);
  }

}