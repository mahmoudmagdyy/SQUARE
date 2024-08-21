class CitiesWithAreamodel {
  final List<CityAndArea> cities;

  CitiesWithAreamodel({required this.cities});

  factory CitiesWithAreamodel.fromJson(Map<String, dynamic> json) {
    var citiesJson = json['data'] as List;
    List<CityAndArea> cities =
        citiesJson.map((city) => CityAndArea.fromJson(city)).toList();
    return CitiesWithAreamodel(cities: cities);
  }
}

class CityAndArea {
  final int id;
  final String name;
  final String image;
  final int status;
  final List<Area> areas;

  CityAndArea(
      {required this.id,
      required this.name,
      required this.image,
      required this.status,
      required this.areas});

  factory CityAndArea.fromJson(Map<String, dynamic> json) {
    var areasJson = json['area'] as List? ?? [];
    List<Area> areas = areasJson.map((area) => Area.fromJson(area)).toList();
    return CityAndArea(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        status: json['status'],
        areas: areas);
  }
}

class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(id: json['id'], name: json['name']);
  }
}
