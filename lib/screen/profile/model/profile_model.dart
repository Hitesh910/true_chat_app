class ProfileModel
{
  String? name,email,mobile,bio,uid;

  ProfileModel({this.name, this.email, this.mobile, this.bio,this.uid});

  factory ProfileModel.mapToModel(Map m1)
  {
    return ProfileModel(name: m1['name'],email: m1['email'],mobile: m1['mobile'],bio: m1['bio'],uid: m1['uid']);
  }
}