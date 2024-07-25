import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/enrollment_student_dialog.dart';
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';

class StudentListView extends StatefulWidget {
  final int? id;
  const StudentListView({super.key, this.id});

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  late final ScrollController scrollController;
  late int currentpage;
  @override
  void initState() {
    super.initState();
    currentpage = 1;
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        0.7 * scrollController.position.maxScrollExtent) {
      setState(() {
        currentpage++;
      });
      BlocProvider.of<ListStudentsBloc>(context)
          .add(StudentsEvents(currentPage: currentpage));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListStudentsBloc, ListStudentsStates>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8 - 90,
          child: (state is ListStudentsSuccessState)
              ? ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 208, 255),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText17(
                              text: "${state.students.data?[index].name}"),
                          CustomText17(
                              text:
                                  "${state.students.data?[index].fatherName}"),
                          MaterialButton(
                              height: 40,
                              color: const Color.fromARGB(255, 230, 87, 255),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                "إضافة الطالب إلى الدورة",
                                // style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EnrollmentStudentDialog(
                                        student: state.students.data![index],
                                        courseId: widget.id!);
                                  },
                                );
                              })
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 4);
                  },
                  itemCount: state.students.data!.length)
              : Center(
                  child: (state is ListStudentsFailureState)
                      ? CustomText20(text: state.message)
                      : const CircularProgressIndicator()),
        );
      },
    );
  }
}
