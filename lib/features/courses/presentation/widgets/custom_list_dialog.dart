import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/student_list_view.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';

class CustomListDialog extends StatefulWidget {
  final int? id;
  const CustomListDialog({this.id, super.key});

  @override
  State<CustomListDialog> createState() => _CustomListDialogState();
}

class _CustomListDialogState extends State<CustomListDialog> {
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
        child: BlocProvider(
          create: (context) => getit.sl<ListStudentsBloc>()
            ..add(const StudentsRegisterEvents(currentPage: 1)),
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
                      CustomText17(text: "اسم الطالب"),
                      CustomText17(text: "اسم الطالب"),
                      CustomText17(text: "اسم الطالب")
                    ],
                  ),
                ),
                StudentListView(id: widget.id),
              ],
            );
          }),
        ),
      ),
    );
  }
}
