import 'package:aqarat/presentation/pages/ticket/data/models/ticket.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/params/ticket_params.dart';
import '../../../../../data/network/error/failure.dart';
import '../datasources/ticket_remote_data_source.dart';

class TicketRepository {
  final TicketRemoteDataSource _ticketRemoteDataSource;

  const TicketRepository(this._ticketRemoteDataSource);
  Future<Either<Failure, Ticket>> getAllUserFavoritesQuestions() async {
    try {
      final response = await _ticketRemoteDataSource.getAllTicket();
      if (response.statusCode == 200) {
        return Right(Ticket.fromMap(response.data));
      } else if (response.statusCode == 500) {
        return Left(AddToFavoriteFailure(response.data['message']));
      }
      return Left(AddToFavoriteFailure(response.data['message']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> createTicket(TicketParams params) async {
    try {
      final response = await _ticketRemoteDataSource.createTicket(params);
      if (response.statusCode == 200) {
        return const Right(unit);
      } else if (response.statusCode == 422) {
        return Left(
          AddToFavoriteFailure(
            response.data['message'],
            statusCode: response.data['data'],
          ),
        );
      }
      return Left(AddToFavoriteFailure(response.data['message']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
