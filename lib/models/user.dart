part of models;

@JsonSerializable()
class User {
  User();

  String id;
  String name;
  String userName;
  String status;
  String token;
  int tokenExpires;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
