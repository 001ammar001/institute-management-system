class FiltersStudentModel  {

  final int pageNumber;
  final bool getArchived;
  final String arabicNameStudent;
  final String englishNameStudent;
  final String fatherName;
  final String motherName;
  final String createDate;
  final String educationLevel;
  final String lineNumber;

  FiltersStudentModel(
      {
    required this.pageNumber,
    required this.getArchived,
    required this.arabicNameStudent,
    required this.englishNameStudent,
    required this.fatherName,
    required this.motherName,
    required this.createDate,
    required this.educationLevel,
    required this.lineNumber,
  });

}