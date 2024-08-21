import 'dart:developer';

import 'package:aqarat/presentation/pages/ticket/data/repositories/ticket_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/ticket_params.dart';
import '../../../../core/utils/enums.dart';
import '../../../../data/network/error/failure.dart';
import '../data/models/ticket.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final TicketRepository _ticketRepository;
  TicketCubit(
    this._ticketRepository,
  ) : super(const TicketState());

  void getAllTicket() async {
    emit(state.copyWith(getAllTicketRequestState: RequestState.loading));

    final response = await _ticketRepository.getAllUserFavoritesQuestions();

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            getAllTicketRequestState: RequestState.error,
            allTicketsErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getAllTicketRequestState: RequestState.loaded,
            allTickets: data,
          ),
        );
      },
    );
  }

  void createNewTicket(TicketParams params) async {
    emit(state.copyWith(createTicketRequestState: RequestState.loading));

    final response = await _ticketRepository.createTicket(params);

    response.fold(
      (failure) {
        log('createNewTicket $failure');
        emit(
          state.copyWith(
            createTicketRequestState: RequestState.error,
            createTicketErrorMessage: failure,
          ),
        );
      },
      (data) {
        emit(state.copyWith(createTicketRequestState: RequestState.loaded));
      },
    );
  }
}
