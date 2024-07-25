class FiltersCourseModel {
  final int pageNumber;
  final bool getArchived;
  final String status;
  final String teacher;
  final String room;
  final String subject;
  final String startAt;
  final String endAt;

  FiltersCourseModel({
    required this.pageNumber,
    required this.getArchived,
    required this.status,
    required this.teacher,
    required this.room,
    required this.subject,
    required this.startAt,
    required this.endAt,
  });
}
