part of models;

@JsonSerializable()
class User {
  User();

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'username')
  String userName;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'tokenExpires')
  int tokenExpires;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
