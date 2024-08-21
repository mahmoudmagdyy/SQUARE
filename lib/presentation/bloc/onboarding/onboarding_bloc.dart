import 'dart:async';
import 'dart:developer';
import '/index.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AppPreferences _preferences;
  OnboardingBloc(this._preferences) : super(const OnboardingState()) {
    on<OnChangePage>(_onChanegdPage);
    on<NextPage>(_nextPage);
    on<PreviousPage>(_previousPage);
    on<GetStartedPressed>(_getStartedPressed);
  }

  void _onChanegdPage(
    OnChangePage event,
    Emitter<OnboardingState> emit,
  ) =>
      emit(OnboardingState(currentPage: event.index));

  void _nextPage(
    NextPage event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentPage != 2) {
      event.pageController.animateToPage(
        state.currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      emit(OnboardingState(currentPage: state.currentPage + 1));
    } else {
      _preferences.onSubmittedOnboarding;
    }
  }

  void _previousPage(
    PreviousPage event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentPage > 0) {
      event.pageController.animateToPage(
        state.currentPage - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      emit(OnboardingState(currentPage: state.currentPage - 1));
    }
  }

  Future<void> _getStartedPressed(
    GetStartedPressed event,
    Emitter<OnboardingState> emit,
  ) async {
    log("${state.currentPage}");
    _preferences.onSubmittedOnboarding;
    i<NavigationService>().toNamedAndRemoveUntil(Routes.login);
    /* Navigator.of(event.context).push(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      ); */
  }
}
