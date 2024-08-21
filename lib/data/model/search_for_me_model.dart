class Property {
  final int id;
  final City city;
  final Area area;
  final Category category;
  final String type;
  final Price price;
  final String space;
  final String code;
  final String createdAt;
  final String desc;

  Property({
    required this.id,
    required this.city,
    required this.area,
    required this.category,
    required this.type,
    required this.price,
    required this.space,
    required this.code,
    required this.createdAt,
    required this.desc,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      desc: json['desc'],
      city: City.fromJson(json['city']),
      area: Area.fromJson(json['area']),
      category: Category.fromJson(json['category']),
      type: json['type'],
      price: Price.fromJson(json['price']),
      space: json['space'],
      code: json['code'],
      createdAt: json['created_at'],
    );
  }
}

class City {
  final int id;
  final String name;
  final String image;
  final int status;

  City(
      {required this.id,
      required this.name,
      required this.image,
      required this.status});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
    );
  }
}

class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Price {
  final int to;
  final int from;

  Price({required this.to, required this.from});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      to: json['to'],
      from: json['from'],
    );
  }
}

class SearchForMeModel {
  final List<Property> newProperties;
  final List<Property> accepted;
  final List<Property> rejected;

  SearchForMeModel(
      {required this.newProperties,
      required this.accepted,
      required this.rejected});

  factory SearchForMeModel.fromJson(Map<String, dynamic> json) {
    return SearchForMeModel(
      newProperties:
          List<Property>.from(json['new'].map((x) => Property.fromJson(x))),
      accepted: List<Property>.from(
          json['accepted'].map((x) => Property.fromJson(x))),
      rejected: List<Property>.from(
          json['rejected'].map((x) => Property.fromJson(x))),
    );
  }
}
