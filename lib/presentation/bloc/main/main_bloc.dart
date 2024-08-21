import 'dart:developer';

import 'package:aqarat/presentation/pages/talabaty/talabaty_page.dart';

import '../../../index.dart';
import '../../pages/chat/prsentation/screen/main_chat_screen.dart';
import '../../pages/ticket/presentation/screens/support/support_screen.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<ChangePage>((event, emit) => _onChanegdPage(emit, event));
  }
  void _onChanegdPage(Emitter<MainState> emit, ChangePage event) {
    emit(MainState(currentIndex: event.index));
    log("${event.index}");
  }
}
