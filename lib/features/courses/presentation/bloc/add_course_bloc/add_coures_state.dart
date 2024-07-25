part of 'add_coures_bloc.dart';

sealed class AddCourseStates extends Equatable {
  const AddCourseStates();

  @override
  List<Object> get props => [];
}

final class AddUpdateCourseInitialState extends AddCourseStates {}

final class AddUpdateCourseLoadingState extends AddCourseStates {}

final class AddUpdateCourseFailureState extends AddCourseStates {
  final String message;

  const AddUpdateCourseFailureState({required this.message});
}

final class AddUpdateCourseSucessState extends AddCourseStates {}
