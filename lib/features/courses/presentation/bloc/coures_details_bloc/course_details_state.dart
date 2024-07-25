part of 'course_details_bloc.dart';

 class CourseDetailsStates extends Equatable {
  const CourseDetailsStates();

  @override
  List<Object> get props => [];
}

final class CouresDataLoadedState extends CourseDetailsStates {
  final CourseEntity course;

  const CouresDataLoadedState({required this.course});
}

final class CouresDataLoadingState extends CourseDetailsStates {}

final class CouresDataFailureState extends CourseDetailsStates {
  final String message;

  const CouresDataFailureState({required this.message});
}
