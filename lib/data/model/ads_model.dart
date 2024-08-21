import 'package:aqarat/domain/entities/home/ads_entity.dart';

class AdsModel extends AdsEntity {
  const AdsModel({
    required super.id,
    required super.category,
    required super.payment,
    required super.space,
    required super.city,
    required super.area,
    required super.title,
    required super.type,
    required super.price,
    required super.age,
    required super.lat,
    required super.lng,
    required super.description,
    required super.firstImage,
    required super.user,
    required super.property,
    required super.images,
    required super.status,
    required super.views,
    required super.createdAt,
    required super.code,
    required super.typeStatus,

  });

  // factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
  //       id: json['id'] as int,
  //       city: json['city'] as String,
  //       area: json['area'] as String,
  //       title: json['title'] as String,
  //       type: json['type'] as String,
  //       price: json['price'] as String,
  //       age: json['age'] as int,
  //       lat: json['lat'] as String,
  //       lng: json['lng'] as String,
  //       description: json['description'] as String,
  //       firstImage: json['first_image'] as String,
  //       user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  //       property:
  //           PropertyModel.fromJson(json['property'] as Map<String, dynamic>),
  //       images: (json['images'] as List)
  //           .map<ImagesModel>(
  //               (data) => ImagesModel.fromJson(data as Map<String, dynamic>))
  //           .toList(),
  //       status: json['status'] as String,
  //       views: json['views'] as String,
  //       createdAt: json['created_at'] as String,
  //       code: json['code'] as String,
  //     );
  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      typeStatus: json['type_status'],
      id: json['id'],
      payment: json['payment'],
      space: json['space'],
      city: json['city'],
      area: json['area'],
      category: json['category'],
      title: json['title'],
      type: json['type'],
      price: json['price'],
      age: json['age'],
      lat: json['lat'],
      firstImage: json['first_image'],
      lng: json['lng'],
      description: json['description'],
      property: PropertyModel.fromJson(json['property']),
      images: List<ImagesModel>.from(
        (json['images'] as List).map(
          (image) => ImagesModel.fromJson(image),
        ),
      ),
      status: json['status'],
      code: json['code'],
      views: json['views'],
      createdAt: json['created_at'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

// ... (Other model classes remain the same)

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
    );
  }
}

class ImagesModel extends ImagesEntity {
  const ImagesModel({required super.id, required super.image});

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        id: json['id'] as int,
        image: json['image'] as String,
      );
}

class PropertyModel extends PropertyEntity {
  const PropertyModel({required super.questions, required super.tools});

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        questions: (json['questions'] as List)
            .map<QuestionsModel>(
                (data) => QuestionsModel.fromJson(data as Map<String, dynamic>))
            .toList(),
        tools: (json['tools'] as List)
            .map<TypesAndToolsModel>((data) =>
                TypesAndToolsModel.fromJson(data as Map<String, dynamic>))
            .toList(),
      );
}

class TypesAndToolsModel extends TypesAndToolsEntity {
  const TypesAndToolsModel({required super.id, required super.title});

  factory TypesAndToolsModel.fromJson(Map<String, dynamic> json) =>
      TypesAndToolsModel(id: json['id'] as int, title: json['title'] as String);
}

class QuestionsModel extends QuestionsEntity {
  const QuestionsModel({
    required super.id,
    required super.title,
    required super.value,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        id: json['id'] as int,
        title: json['title'] as String,
        value: json['value'],
      );
}
