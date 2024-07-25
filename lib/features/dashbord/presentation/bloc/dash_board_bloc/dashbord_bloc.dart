import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "dashbord_events.dart";
part "dashbord_states.dart";

class DashBoardBloc extends Bloc<DashBordEvent, DashBordStates> {
  // todo: you will need to add all the useCases here

  DashBoardBloc() : super(DashBordInitialState()) {
    on<DashBordEvent>((event, emit) {});
  }
}
