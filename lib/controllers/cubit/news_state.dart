part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsBottomNavigationBar extends NewsState {}

class NewsGetBuisnessLoadingState extends NewsState {}

class NewsGetBuisnessSuccessState extends NewsState {}

class NewsGetBuisnessFailiureState extends NewsState {
  String error;
  NewsGetBuisnessFailiureState({
    required this.error
});
}
class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsFailiureState extends NewsState {
  String error;

  NewsGetSportsFailiureState({
    required this.error
  });
}
  class NewsGetScienceLoadingState extends NewsState {}

  class NewsGetScienceSuccessState extends NewsState {}

  class NewsGetScienceFailiureState extends NewsState {
  String error;
  NewsGetScienceFailiureState({
  required this.error
  });
  }

  class NewsChangeMode extends NewsState{}

class NewsSearchLoadingState extends NewsState {}

class NewsSearchSuccessState extends NewsState {}

class NewsSearchFailiureState extends NewsState {
  String error;
  NewsSearchFailiureState({
    required this.error
  });
}
