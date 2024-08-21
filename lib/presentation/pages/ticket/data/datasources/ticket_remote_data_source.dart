import 'package:dio/dio.dart';

import '../../../../../core/params/ticket_params.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/api_constances.dart';
import '../../../../../core/utils/app_prefs.dart';
import '../../../../../data/network/dio/dio_factory.dart';

class TicketRemoteDataSource {
  // final ApiConsumer _apiConsumer;

  const TicketRemoteDataSource(); //this._apiConsumer

  Future<Response> getAllTicket() async {
    final response = await DioFactory().get(
      ApiConstance.report,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );

    return response;
  }

  Future<Response> createTicket(TicketParams params) async {
    final response = await DioFactory().post(
      ApiConstance.report,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
      data: params.toMap(),
    );

    return response;
  }
}
