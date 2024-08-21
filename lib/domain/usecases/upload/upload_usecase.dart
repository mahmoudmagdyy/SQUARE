import 'dart:io';

import '/index.dart';

class UploadUseCase extends UseCaseWithParams<void, UploadParameter> {
  final BaseUploadAqarRepository _repository;

  UploadUseCase(this._repository);
  @override
  ResultFuture<void> call(UploadParameter params) async =>
      await _repository.upload(
        UploadParameter(
          typeStatus: params.typeStatus,
          payment: params.payment,
          space: params.space,
          adIdType: params.adIdType,
          aqarIdType: params.aqarIdType,
          cityId: params.cityId,
          areaId: params.areaId,
          lat: params.lat,
          lng: params.lng,
          firstImage: params.firstImage,
          images: params.images,
          price: params.price,
          questions: params.questions,
          age: params.age,
          title: params.title,
          description: params.description,
          tools: params.tools,
        ),
      );
}

class UploadParameter extends Equatable {
  final int? cat_id;
  final String? adIdType;
  final String? aqarIdType;
  final String? cityId;
  final String? areaId;
  final String? payment;
  final String? typeStatus;
  final int? space;

  final String? lat;
  final String ?lng;
  final File? firstImage;
  final List<File> ?images;
  final String? price;
  final List<Map<String, dynamic>>? questions;
  final String ?age;
  final String? title;
  final String ?description;
  final List<String>? tools;
  final List<int>? deletImages;

  const UploadParameter(
      {
        this.deletImages,
        this.cat_id,
     this.typeStatus,
     this.payment,
     this.space,
    this.adIdType,
    this.aqarIdType,
    this.cityId,
    this.areaId,
     this.lat,
     this.lng,
    this.firstImage,
      this.images,
     this.price,
       this.questions,
     this.age,
     this.title,
     this.description,
     this.tools,
  });

  @override
  List<Object?> get props => [
        typeStatus,
        adIdType,
        aqarIdType,
        cityId,
        areaId,
        lat,
        lng,
        firstImage,
        images,
        price,
        questions,
        age,
        title,
        description,
        tools,
      ];
}
