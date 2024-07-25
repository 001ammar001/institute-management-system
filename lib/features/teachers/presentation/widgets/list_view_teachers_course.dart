import 'package:flutter/material.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/presentation/widgets/item_builder_teachers_course.dart';

class TeacherListCourse extends StatelessWidget {
  const TeacherListCourse({super.key, required this.course});
  final List<TeacherCourse> course;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.separated(
        itemCount: course.length,
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.green.shade200,
          );
        },
        itemBuilder: (context, index) {
          return BuilderItemTeacherCourses(
              firstText: course[index].courseName,
              secondText: course[index].courseDate);
        },
      ),
    );
  }
}
