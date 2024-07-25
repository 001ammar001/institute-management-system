import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/add_job_body.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

//TODO: maybe no need to use job-title-details bloc any more

class AddJobPage extends StatefulWidget {
  final JobEntity? job;
  const AddJobPage({super.key, this.job});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  late TextEditingController nameController;
  late TextEditingController salaryController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.job?.name);
    salaryController =
        TextEditingController(text: widget.job?.baseSalary.toString());

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    salaryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    final size = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TitleWhitBackButton(
            text: widget.job != null ? "تعديل مسمى وظيفي" : "إضافة مسمى وظيفي",
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
          ),
          AddJobBody(
            id: widget.job?.id,
            formKey: formKey,
            size: size,
            nameController: nameController,
            salaryController: salaryController,
          )
        ],
      ),
    );
  }
}
