// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class Property {
//   final int id;
//   final String city;
//   final String area;
//   final String title;
//   final String type;
//   final String price;
//   int age;
//   final String lat;
//   final String lng;
//   final String description;
//   final String firstImage;
//   final User user;
//   final PropertyClass property;
//   final List<Image> images;
//   final String status;
//   final String views;
//   final String createdAt;

//   Property({
//     required this.id,
//     required this.city,
//     required this.area,
//     required this.title,
//     required this.type,
//     required this.price,
//     required this.age,
//     required this.lat,
//     required this.lng,
//     required this.description,
//     required this.firstImage,
//     required this.user,
//     required this.property,
//     required this.images,
//     required this.status,
//     required this.views,
//     required this.createdAt,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'city': city,
//       'area': area,
//       'title': title,
//       'type': type,
//       'price': price,
//       'age': age,
//       'lat': lat,
//       'lng': lng,
//       'description': description,
//       'first_image': firstImage,
//       'user': user.toMap(),
//       'images': images.map((x) => x.toMap()).toList(),
//       'status': status,
//       'views': views,
//       'created_at': createdAt,
//     };
//   }

//   factory Property.fromMap(Map<String, dynamic> map) {
//     return Property(
//       id: map['id'] as int,
//       city: map['city'] as String,
//       area: map['area'] as String,
//       title: map['title'] as String,
//       type: map['type'] as String,
//       price: map['price'] as String,
//       age: map['age'] as int,
//       lat: map['lat'] as String,
//       lng: map['lng'] as String,
//       description: map['description'] as String,
//       firstImage: map['first_image'] as String,
//       user: User.fromMap(map['user'] as Map<String, dynamic>),
//       images: List<Image>.from(
//         (map['images'] as List).map<Image>(
//           (x) => Image.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//       status: map['status'] as String,
//       views: map['views'] as String,
//       createdAt: map['created_at'] as String,
//       property: PropertyClass.fromMap(map['property'] as Map<String, dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Property.fromJson(String source) =>
//       Property.fromMap(json.decode(source) as Map<String, dynamic>);

//   // @override
//   // List<Object?> get props => [
//   //       id,
//   //       city,
//   //       area,
//   //       title,
//   //       type,
//   //       price,
//   //       age,
//   //       lat,
//   //       lng,
//   //       description,
//   //       firstImage,
//   //       user,
//   //       property,
//   //       images,
//   //       status,
//   //       views,
//   //       createdAt,
//   //     ];
// }

// class Image {
//   final int id;
//   final String image;

//   const Image({
//     required this.id,
//     required this.image,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'image': image,
//     };
//   }

//   factory Image.fromMap(Map<String, dynamic> map) {
//     return Image(
//       id: map['id'] as int,
//       image: map['image'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Image.fromJson(String source) =>
//       Image.fromMap(json.decode(source) as Map<String, dynamic>);

//   // @override
//   // List<Object?> get props => [
//   //       id,
//   //       image,
//   //     ];
// }

// class PropertyClass extends Equatable {
//   final List<Question>? questions;
//   final List<Tool>? types;
//   final List<Tool>? tools;

//   const PropertyClass({
//     required this.questions,
//     required this.types,
//     required this.tools,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'questions': questions!.map((x) => x.toMap()).toList(),
//       'types': types!.map((x) => x.toMap()).toList(),
//       'tools': tools!.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory PropertyClass.fromMap(Map<String, dynamic> map) {
//     return PropertyClass(
//       questions: map['questions'] != null
//           ? List<Question>.from(
//               (map['questions'] as List).map<Question>(
//                 (x) => Question.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       types: map['types'] != null
//           ? List<Tool>.from(
//               (map['types'] as List).map<Tool>(
//                 (x) => Tool.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       tools: map['tools'] != null
//           ? List<Tool>.from(
//               (map['tools'] as List).map<Tool>(
//                 (x) => Tool.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PropertyClass.fromJson(String source) =>
//       PropertyClass.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   List<Object?> get props => [
//         questions,
//         types,
//         tools,
//       ];

//   PropertyClass copyWith({
//     List<Question>? questions,
//     List<Tool>? types,
//     List<Tool>? tools,
//   }) {
//     return PropertyClass(
//       questions: questions ?? this.questions,
//       types: types ?? this.types,
//       tools: tools ?? this.tools,
//     );
//   }
// }

// class Question extends Equatable {
//   final int id;
//   final String title;
//   dynamic value;

//   Question({required this.id, required this.title, required this.value});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//       'value': value,
//     };
//   }

//   factory Question.fromMap(Map<String, dynamic> map) {
//     return Question(
//       id: map['id'] as int,
//       title: map['title'] as String,
//       value: map['value'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Question.fromJson(String source) =>
//       Question.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         value,
//       ];

//   Question copyWith({int? id, String? title, dynamic value}) {
//     return Question(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         value: value ?? this.value);
//   }
// }

// class Tool extends Equatable {
//   final int id;
//   final String title;

//   const Tool({
//     required this.id,
//     required this.title,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//     };
//   }

//   factory Tool.fromMap(Map<String, dynamic> map) {
//     return Tool(
//       id: map['id'] as int,
//       title: map['title'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Tool.fromJson(String source) =>
//       Tool.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//       ];

//   Tool copyWith({
//     int? id,
//     String? title,
//   }) {
//     return Tool(
//       id: id ?? this.id,
//       title: title ?? this.title,
//     );
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String phone;
//   final String email;
//   final String image;

//   const User({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.image,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'email': email,
//       'image': image,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       phone: map['phone'] as String,
//       email: map['email'] as String,
//       image: map['image'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) =>
//       User.fromMap(json.decode(source) as Map<String, dynamic>);

//   // @override
//   // List<Object?> get props => [
//   //       id,
//   //       name,
//   //       phone,
//   //       email,
//   //       image,
//   //     ];
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Property {
  final int id;
  String city;
  String? payment;
  int? space;
  String area;
  String title;
  String type;
  String price;
  int age;
  String lat;
  String lng;
  String description;
  String? firstImage;
  String? typeStatus;
  User user;
  PropertyClass property;
  List<Image> images;
  String status;
  String views;
  String createdAt;
  String category;
  String code;
  int? share;

  Property({
    required this.category,
    required this.code,
    required this.payment,
    required this.space,
    required this.id,
    required this.city,
    required this.area,
    required this.title,
    required this.type,
    required this.price,
    required this.age,
    required this.lat,
    required this.lng,
    required this.description,
    required this.firstImage,
    required this.user,
    required this.property,
    required this.images,
    required this.status,
    required this.views,
    required this.createdAt,
    this.typeStatus,
    this.share,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'area': area,
      'title': title,
      'type': type,
      'price': price,
      'age': age,
      'lat': lat,
      'lng': lng,
      'description': description,
      'first_image': firstImage,
      'user': user.toMap(),
      'images': images.map((x) => x.toMap()).toList(),
      'status': status,
      'views': views,
      'type_status': typeStatus,
      'created_at': createdAt,
      'share': share,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] as int,
      city: map['city'] as String,
      area: map['area'] as String,
      category: map['category'] as String,
      code: map['code'] as String,
      title: map['title'] as String,
      payment: map['payment'] as String?,
      space: map['space'] as int?,
      type: map['type'] as String,
      price: map['price'] as String,
      age: map['age'] as int,
      lat: map['lat'] as String,
      lng: map['lng'] as String,
      description: map['description'] as String,
      typeStatus: map['type_status'] as String?,
      firstImage: map['first_image'] as String,
      share: map['share'],
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      images: List<Image>.from(
        (map['images'] as List).map<Image>(
          (x) => Image.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
      views: map['views'] as String,
      createdAt: map['created_at'] as String,
      property: PropertyClass.fromMap(map['property'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source) as Map<String, dynamic>);

  Property copyWith({
    int? id,
    String? city,
    String? payment,
    int? space,
    String? area,
    String? title,
    String? type,
    String? price,
    int? age,
    String? lat,
    String? lng,
    String? description,
    String? firstImage,
    User? user,
    PropertyClass? property,
    List<Image>? images,
    String? status,
    String? views,
    String? createdAt,
    String? category,
    String? code,
    int? share,
  }) {
    return Property(
      id: id ?? this.id,
      city: city ?? this.city,
      payment: payment ?? this.payment,
      space: space ?? this.space,
      area: area ?? this.area,
      title: title ?? this.title,
      type: type ?? this.type,
      price: price ?? this.price,
      age: age ?? this.age,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      description: description ?? this.description,
      firstImage: firstImage ?? this.firstImage,
      user: user ?? this.user,
      property: property ?? this.property,
      images: images ?? this.images,
      status: status ?? this.status,
      views: views ?? this.views,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      code: code ?? this.code,
      share: share ?? this.share,
    );
  }
}

class Image {
  final int id;
  final String image;
  final bool? isFileImage;

  const Image({
    required this.id,
    required this.image,
    this.isFileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) =>
      Image.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // List<Object?> get props => [
  //       id,
  //       image,
  //     ];
}

class PropertyClass extends Equatable {
  List<Question>? questions;
  // final List<Tool>? types;
  List<Tool>? tools;

  PropertyClass({
    required this.questions,
    // required this.types,
    required this.tools,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questions': questions!.map((x) => x.toMap()).toList(),
      // 'types': types!.map((x) => x.toMap()).toList(),
      'tools': tools!.map((x) => x.toMap()).toList(),
    };
  }

  factory PropertyClass.fromMap(Map<String, dynamic> map) {
    return PropertyClass(
      questions: map['questions'] != null
          ? List<Question>.from(
              (map['questions'] as List).map<Question>(
                (x) => Question.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      // types: map['types'] != null
      //     ? List<Tool>.from(
      //         (map['types'] as List).map<Tool>(
      //           (x) => Tool.fromMap(x as Map<String, dynamic>),
      //         ),
      //       )
      //     : null,
      tools: map['tools'] != null
          ? List<Tool>.from(
              (map['tools'] as List).map<Tool>(
                (x) => Tool.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyClass.fromJson(String source) =>
      PropertyClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        questions,
        // types,
        tools,
      ];

  PropertyClass copyWith({
    List<Question>? questions,
    List<Tool>? types,
    List<Tool>? tools,
  }) {
    return PropertyClass(
      questions: questions ?? this.questions,
      // types: types ?? this.types,
      tools: tools ?? this.tools,
    );
  }
}

class Question extends Equatable {
  final int id;
  final String title;
  String value;

  Question({required this.id, required this.title, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'value': value,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      title: map['title'] as String,
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        title,
        value,
      ];

  Question copyWith({int? id, String? title, String? value}) {
    return Question(
        id: id ?? this.id,
        title: title ?? this.title,
        value: value ?? this.value);
  }
}

class Tool extends Equatable {
  final int id;
  final String title;

  const Tool({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tool.fromJson(String source) =>
      Tool.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [id, title];

  Tool copyWith({
    int? id,
    String? title,
  }) {
    return Tool(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  bool get stringify => true;
}

class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String image;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // List<Object?> get props => [
  //       id,
  //       name,
  //       phone,
  //       email,
  //       image,
  //     ];
}
