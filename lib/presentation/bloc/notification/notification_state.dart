// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.getAllNotificationRequestState = RequestState.none,
    this.allNotification,
    this.getAllNotificationErrorState,
    this.removeNotificationErrorState,
    this.removeNotificationRequestState = RequestState.none,
    this.updateNotificationErrorState,
    this.updateNotificationRequestState = RequestState.none,
  });

  //! Get All Notification
  final RequestState getAllNotificationRequestState;
  final NotificationModel? allNotification;
  final String? getAllNotificationErrorState;

  //! Update Notification State
  final RequestState updateNotificationRequestState;
  final String? updateNotificationErrorState;

  //! Remove Notification
  final RequestState removeNotificationRequestState;
  final String? removeNotificationErrorState;

  @override
  List<Object?> get props => [
        getAllNotificationRequestState,
        allNotification,
        getAllNotificationErrorState,
        removeNotificationErrorState,
        removeNotificationRequestState,
        updateNotificationErrorState,
        updateNotificationRequestState
      ];

  NotificationState copyWith({
    RequestState? getAllNotificationRequestState,
    NotificationModel? allNotification,
    String? getAllNotificationErrorState,
    RequestState? updateNotificationRequestState,
    String? updateNotificationErrorState,
    RequestState? removeNotificationRequestState,
    String? removeNotificationErrorState,
  }) {
    return NotificationState(
      getAllNotificationRequestState:
          getAllNotificationRequestState ?? this.getAllNotificationRequestState,
      allNotification: allNotification ?? this.allNotification,
      getAllNotificationErrorState:
          getAllNotificationErrorState ?? this.getAllNotificationErrorState,
      updateNotificationRequestState:
          updateNotificationRequestState ?? this.updateNotificationRequestState,
      updateNotificationErrorState:
          updateNotificationErrorState ?? this.updateNotificationErrorState,
      removeNotificationRequestState:
          removeNotificationRequestState ?? this.removeNotificationRequestState,
      removeNotificationErrorState:
          removeNotificationErrorState ?? this.removeNotificationErrorState,
    );
  }
}
