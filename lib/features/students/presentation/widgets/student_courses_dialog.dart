import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/features/students/presentation/widgets/student_list_courses.dart';

class StudentCoursesDialog extends StatelessWidget {
  final int id;
  const StudentCoursesDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 238, 251),
            borderRadius: BorderRadius.circular(5)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 231, 108, 253),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText17(text: "اسم الدورة"),
                    CustomText17(text: "تاريخ البداية"),
                  ],
                ),
              ),
              StudentCourseList(studentId: id)
            ],
          );
        }),
      ),
    );
  }
}
