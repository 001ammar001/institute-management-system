part of "dashbord_bloc.dart";

sealed class DashBordStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashBordInitialState extends DashBordStates {}

class DashBordLoadingState extends DashBordStates {}

class DashBordLoadingComplete extends DashBordStates {}

class DashBordErrorState extends DashBordStates {
  final String message;

  DashBordErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
