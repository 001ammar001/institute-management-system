part of 'enrollment_bloc.dart';

sealed class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class AddEnrollment extends EnrollmentEvent {
  final EnrollmentModel enrollmentModel;
  const AddEnrollment({required this.enrollmentModel});
}
