class UserProfileResponse {
  String id = "";
  String phone = "";
  String? gender = "";
  String fullName = "";
  String place = "";
  String? avatarPath = "";
  String? bio = "";
  List<String>? friend;
  String? createdAt = "";
  String? backgroundPath = "";
  String age = "";
  UserProfileResponse(
      this.id,
      this.phone,
      this.gender,
      this.fullName,
      this.place,
      this.avatarPath,
      this.bio,
      this.friend,
      this.createdAt,
      this.backgroundPath,
      this.age);
  UserProfileResponse.buildDefault();
  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    List<String> friendResponse = [];
    if (json['friends'] != null) {
      List<dynamic> arrData = json['friends'];
      for (var i = 0; i < arrData.length; i++) {
        String friend = arrData[i];
        friendResponse.add(friend);
      }
    }
    return UserProfileResponse(
      json['_id'],
     json['phone'],
      json['gender'],
      json['full_name'],
      json['place'],
      json['avatar_path'],
      json['bio'],
      friendResponse,
      json['createdAt'],
      json['background_path'],
      json['age'],
    );
  }
}
