class AppUser {
  final String uid;
  final String email;

  AppUser({required this.uid, required this.email});
  //convert appuser - json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  //convert json - appuser
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] ,
      email: json['email'],
    );
  }
}
