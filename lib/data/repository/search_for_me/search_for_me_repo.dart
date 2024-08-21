import 'package:aqarat/data/data_source/remote/search_for_me/search_for_me_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../core/params/search_for_me_params.dart';
import '../../model/search_for_me_model.dart';
import '../../network/error/failure.dart';

class SearchForMeRepository {
  final SearchForMeDataSource remoteDataSource;
  SearchForMeRepository({required this.remoteDataSource});

  Future<Either<Failure, String>> searchForMe(SearchForMeParams params) async {
    try {
      final response = await remoteDataSource.searchForMe(params);
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else if (response.statusCode == 500) {
        return Left(SearchForMeFailure(response.data['message']));
      }
      return Left(SearchForMeFailure(response.data['message']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, SearchForMeModel>> getSearchForMe() async {
    try {
      final response = await remoteDataSource.getSearchForMe();
      if (response.statusCode == 200) {
        return Right(SearchForMeModel.fromJson(response.data['data']));
      } else if (response.statusCode == 500) {
        return Left(SearchForMeFailure(response.data['message']));
      }
      return Left(SearchForMeFailure(response.data['message']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
