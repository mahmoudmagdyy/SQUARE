import 'package:aqarat/index.dart';

part 'search_for_me_event.dart';
part 'search_for_me_state.dart';

class SearchForMeBloc extends Bloc<SearchForMeEvent, SearchForMeInitial> {
  SearchForMeBloc(this.uploadBloc) : super(const SearchForMeInitial()) {
    on<GetCheckBox1Event>(_getCheckBox1Event);
    on<GetCheckBox2Event>(_getCheckBox2Event);
  }
  final UploadAqarBloc uploadBloc;
  void _getCheckBox1Event(
          GetCheckBox1Event event, Emitter<SearchForMeState> emit) =>
      emit(state.copyWith(isCheckBox1: event.isCheckBox1));

  void _getCheckBox2Event(
          GetCheckBox2Event event, Emitter<SearchForMeState> emit) =>
      emit(state.copyWith(isCheckBox2: event.isCheckBox2));
}
