part of 'rooms_and_categorys_bloc.dart';

sealed class RoomsAndCategorysState extends Equatable {
  const RoomsAndCategorysState();

  @override
  List<Object> get props => [];
}

final class RoomsAndCategorysInitialState extends RoomsAndCategorysState {}

final class RoomsAndCategorysLoadingState extends RoomsAndCategorysState {}

final class RoomsAndCategorysFailureState extends RoomsAndCategorysState {
  final String message;

  const RoomsAndCategorysFailureState({required this.message});
}

final class RoomsAndCategorysSucessState extends RoomsAndCategorysState {}
