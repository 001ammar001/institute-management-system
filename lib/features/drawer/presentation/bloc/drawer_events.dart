part of "drawer_bloc.dart";

abstract class DrawerEvents extends Equatable {}

class ChangeWidgetEvent extends DrawerEvents {
  ChangeWidgetEvent();

  @override
  List<Object?> get props => [];
}
