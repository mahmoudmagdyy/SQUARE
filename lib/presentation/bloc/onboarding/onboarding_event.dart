part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnChangePage extends OnboardingEvent {
  final int index;

  const OnChangePage(this.index);

  @override
  List<Object> get props => [index];
}

class NextPage extends OnboardingEvent {
  final int index;
  final PageController pageController;
  const NextPage(this.pageController, this.index);
  @override
  List<Object> get props => [pageController, index];
}

class PreviousPage extends OnboardingEvent {
  final int index;
  final PageController pageController;
  const PreviousPage(this.pageController, this.index);
  @override
  List<Object> get props => [pageController, index];
}

class GetStartedPressed extends OnboardingEvent {
  final BuildContext context;

  const GetStartedPressed(this.context);
}
