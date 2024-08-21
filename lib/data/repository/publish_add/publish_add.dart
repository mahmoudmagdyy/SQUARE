import 'package:aqarat/data/model/ads_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/params/publish_add_params.dart';
import '../../../domain/entities/home/ads_entity.dart';
import '../../data_source/remote/publish_add/publish_add.dart';
import '../../model/slider_model.dart';
import '../../network/error/failure.dart';

class PublishAddRepository {
  final PublishAddDataSource remoteDataSource;

  PublishAddRepository(this.remoteDataSource);

  Future<Either<Failure, List<SlidersModel>>> getpublishAddSlider() async {
    try {
      print('getpublishAddSlider');
      final response = await remoteDataSource.getpublishAddSlider();
      if (response.statusCode == 200) {
        print('getpublishAddSlider 200');
        List data = response.data['data'];
        return Right(
          data.map((e) => SlidersModel.fromJson(e)).toList(),
        );
      } else if (response.statusCode == 500) {
        print('getpublishAddSlider 500');
        return Left(SliderFailure(response.data['message']));
      }
      return Left(SliderFailure(response.data['message']));
    } catch (e) {
      print('slider error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> getAdminPhoneNumber() async {
    try {
      print('getAdminPhoneNumber');
      final response = await remoteDataSource.getAdminPhoneNumber();
      if (response.statusCode == 200) {
        print('getAdminPhoneNumber 200');
        String adminPhoneNumber = response.data['data']['value'];
        return Right(
          adminPhoneNumber,
        );
      } else if (response.statusCode == 500) {
        print('getAdminPhoneNumber 500');
        return Left(SliderFailure(response.data['message']));
      }
      return Left(SliderFailure(response.data['message']));
    } catch (e) {
      print('slider error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AdsEntity>>> getpublishAdd(
      {required PublishAddParams params}) async {
    try {
      print('getpublishAdd');
      final response = await remoteDataSource.getpublishAdd(params: params);
      if (response.statusCode == 200) {
        print('getpublishAdd 200');
        List data = response.data['data'];
        return Right(
          data.map((e) => AdsModel.fromJson(e)).toList(),
        );
      } else if (response.statusCode == 500) {
        print('getpublishAdd 500');
        return Left(SliderFailure(response.data['message']));
      }
      return Left(SliderFailure(response.data['message']));
    } catch (e) {
      print('slider error $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
