import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/employees/presentation/bloc/enrollment/enrollment_bloc.dart';
import 'package:institute_management_system/features/students/data/models/student_model_list.dart';

class EnrollmentStudentDialog extends StatefulWidget {
  final Students student;
  final int courseId;
  const EnrollmentStudentDialog(
      {super.key, required this.student, required this.courseId});

  @override
  State<EnrollmentStudentDialog> createState() =>
      _EnrollmentStudentDialogState();
}

class _EnrollmentStudentDialogState extends State<EnrollmentStudentDialog> {
  late bool checkBoxValue;
  late TextEditingController payment;
  late int withcertificate;
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    checkBoxValue = false;
    payment = TextEditingController();
    withcertificate = 0;
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.sl<EnrollmentBloc>(),
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
            builder: (context, state) {
              if (state is AddingEnrollmentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AddingEnrollmentSucess) {
                return const Center(child: Text("تم إضافة الطالب بنجاح"));
              } else if (state is AddingEnrollmentFailure) {
                return Center(child: Text(state.message));
              }
              return Column(
                key: formKey,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText20(text: "الطالب : ${widget.student.name}"),
                  EnabledTextField(controller: payment, label: "إضافة دفعة"),
                  CheckboxListTile(
                      title: const Text("مع طلب شهادة"),
                      value: checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          checkBoxValue = value!;
                          withcertificate = (withcertificate == 0) ? 1 : 0;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          final int paymentvalue = (payment.text.isEmpty)
                              ? 0
                              : (payment.text.isNum)
                                  ? int.parse(payment.text)
                                  : 0;
                          final newEnrollment = EnrollmentModel(
                              studentId: widget.student.id!,
                              courseId: widget.courseId,
                              withCertificate: withcertificate,
                              initialPayment: paymentvalue);
                          BlocProvider.of<EnrollmentBloc>(context).add(
                              AddEnrollment(enrollmentModel: newEnrollment));
                        },
                        child: const Text("تأكيد"),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          navigator?.pop();
                        },
                        child: const Text("تراجع"),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
