import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/employees/presentation/bloc/employee_detials_bloc/employee_details_bloc.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getit.sl<EmployeeDetailsBloc>()..add(GetEmployeeDetailEvent(id: id)),
      child: Center(
        child: BlocConsumer<EmployeeDetailsBloc, EmployeeDetailsStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return (state is EmployeeDataLoadedState)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 7,
                              blurRadius: 7,
                              color: Color.fromARGB(82, 128, 128, 128)),
                        ],
                        color: const Color.fromARGB(255, 238, 218, 238)),
                    child: Column(children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText20(
                                        text: "الاسم:${state.employee.name}"),
                                    CustomText20(text: "الراتب:30000  "),
                                    CustomText20(
                                        text:
                                            "المسمى الوظيفي :${state.employee.job.name}"),
                                    CustomText20(
                                        text:
                                            "الدوام :${state.employee.shift.name}"),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText20(
                                        text:
                                            "تاريخ الولادة :${state.employee.birthDate}"),
                                    CustomText20(
                                        text:
                                            "رقم الهاتف:${state.employee.phoneNumber}"),
                                    CustomText20(
                                        text: "السعر الخاص بالوظيفة:30000"),
                                  ],
                                )
                              ],
                            )),
                      )
                    ]),
                  )
                : (state is EmployeeDataFailureState)
                    ? CustomText25(text: state.message)
                    : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
