part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  const TicketState({
    this.allTickets,
    this.allTicketsErrorMessage,
    this.createTicketErrorMessage,
    this.createTicketRequestState = RequestState.none,
    this.getAllTicketRequestState = RequestState.none,
  });

  //! Get All Ticket
  final RequestState getAllTicketRequestState;
  final Ticket? allTickets;
  final String? allTicketsErrorMessage;

  //! Create New Ticket
  final RequestState createTicketRequestState;
  final Failure? createTicketErrorMessage;

  @override
  List<Object?> get props => [
        allTickets,
        allTicketsErrorMessage,
        createTicketErrorMessage,
        createTicketRequestState,
        getAllTicketRequestState,
      ];

  TicketState copyWith({
    RequestState? getAllTicketRequestState,
    Ticket? allTickets,
    String? allTicketsErrorMessage,
    RequestState? createTicketRequestState,
    Failure? createTicketErrorMessage,
  }) {
    return TicketState(
      getAllTicketRequestState:
          getAllTicketRequestState ?? this.getAllTicketRequestState,
      allTickets: allTickets ?? this.allTickets,
      allTicketsErrorMessage:
          allTicketsErrorMessage ?? this.allTicketsErrorMessage,
      createTicketRequestState:
          createTicketRequestState ?? this.createTicketRequestState,
      createTicketErrorMessage:
          createTicketErrorMessage ?? this.createTicketErrorMessage,
    );
  }
}
