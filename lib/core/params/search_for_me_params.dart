// ignore_for_file: public_member_api_docs, sort_constructors_first

class SearchForMeParams {
  final int cityId;
  final int areaId;
  final int catId;
  final int type;
  final int fromPrice;
  final int toPrice;
  final String desc;

  final int space;
  SearchForMeParams({
    required this.desc,
    required this.fromPrice,
    required this.toPrice,
    required this.cityId,
    required this.areaId,
    required this.catId,
    required this.type,
    required this.space,
  });
}
