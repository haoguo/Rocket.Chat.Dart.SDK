part of models;

class Info {}

@JsonSerializable()
class Pagination {
  Pagination();

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'total')
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
