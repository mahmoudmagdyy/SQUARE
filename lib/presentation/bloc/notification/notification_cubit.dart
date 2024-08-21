import 'dart:developer';

import 'package:aqarat/data/model/notification.dart';
import 'package:aqarat/data/repository/notification/notification_repository.dart';
import 'package:aqarat/index.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;
  NotificationCubit(
    this._notificationRepository,
  ) : super(const NotificationState());

  void getAllNotification() async {
    emit(state.copyWith(getAllNotificationRequestState: RequestState.loading));

    final result = await _notificationRepository.getAllNotification();

    result.fold(
      (l) {
        log('Error in Get All Notification $l');
        emit(
          state.copyWith(
            getAllNotificationRequestState: RequestState.error,
            getAllNotificationErrorState: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            getAllNotificationRequestState: RequestState.loaded,
            allNotification: r,
          ),
        );
      },
    );
  }

  void updateNotificationStatus(int id, int index) async {
    emit(state.copyWith(updateNotificationRequestState: RequestState.loading));

    final result = await _notificationRepository.updateNotificationStatus(id);

    result.fold(
      (l) {
        log('Error in Update Notification Status $l');
        emit(
          state.copyWith(
            updateNotificationRequestState: RequestState.error,
            updateNotificationErrorState: l.message,
          ),
        );
      },
      (r) {
        state.allNotification!.data![index].status = 1;

        emit(
          state.copyWith(
            updateNotificationRequestState: RequestState.loaded,
          ),
        );
      },
    );
  }

  void removeNotification(int id) async {
    emit(state.copyWith(removeNotificationRequestState: RequestState.loading));

    final result = await _notificationRepository.deleteNotificationStatus(id);

    result.fold(
      (l) {
        log('Error in Remove Notification $l');
        emit(
          state.copyWith(
            removeNotificationRequestState: RequestState.error,
            removeNotificationErrorState: l.message,
          ),
        );
      },
      (r) {
        state.allNotification!.data!.removeWhere((element) => element.id == id);
        emit(state.copyWith(
            removeNotificationRequestState: RequestState.loaded));
      },
    );
  }
}
