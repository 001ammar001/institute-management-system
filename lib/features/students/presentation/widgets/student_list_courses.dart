import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/features/students/presentation/bloc/student_course/student_course_bloc.dart';

class StudentCourseList extends StatelessWidget {
  final int studentId;
  const StudentCourseList({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<StudentCourseBloc>()..add(GetStudentCourse(id: studentId)),
      child: BlocBuilder<StudentCourseBloc, StudentCourseState>(
        builder: (context, state) {
          return (state is StudentCourseSuccess)
              ? ((state.studentCourseModelList.data!.isNotEmpty)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8 - 90,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 248, 208, 255),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText17(
                                      text: state.studentCourseModelList
                                          .data![index].subject),
                                  CustomText17(
                                      text: state.studentCourseModelList
                                          .data![index].startdate),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 4);
                          },
                          itemCount: state.studentCourseModelList.data!.length),
                    )
                  : const CustomText25(
                      text: "لا يوجد دورات سجل بها هذا الطالب"))
              : Center(
                  child: (state is StudentCourseFailure)
                      ? CustomText25(text: state.message)
                      : const CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
