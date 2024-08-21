import 'package:aqarat/core/utils/api_constances.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/data/network/dio/dio_factory.dart';
import 'package:dio/dio.dart';

class AdDetailsRemoteDataSource {
  Future<List<Property>> getSimilarAds(int id) async {
    final Response response = await DioFactory().get(
      '${ApiConstance.similarAds}/$id',
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<Property>.from(
        (response.data['data'] as List).map(
          (e) => Property.fromMap(e),
        ),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
