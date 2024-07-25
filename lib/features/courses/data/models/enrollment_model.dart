class EnrollmentModel {
  int studentId;
  int courseId;
  int withCertificate;
  int initialPayment;
  EnrollmentModel(
      {required this.studentId,
      required this.courseId,
      required this.withCertificate,
      required this.initialPayment});

  Map<String, dynamic> toJson() {
    return {
      "student_id": studentId,
      "course_id": courseId,
      "with_certificate": withCertificate,
      "initial_payment": initialPayment
    };
  }
}
