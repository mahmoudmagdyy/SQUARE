part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final int currentPage;

  const OnboardingState({this.currentPage = 0});

  @override
  List<Object> get props => [currentPage];
}
