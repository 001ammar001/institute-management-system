import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/table_screen/table_list_buttons_appbar.dart';
import 'package:institute_management_system/core/widgets/table_screen/table_list_component.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/subjects_list_bloc/subjects_list_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/pages/add_subject_page.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/subjects_list_widgets/subjects_list_body.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

//TODO: we still nead to add search;
TextEditingController valueSearchEmployee = TextEditingController();

class SubjectsListPage extends StatelessWidget {
  const SubjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<SubjectsListBloc>()..add(GetSubjectsEvent()),
      child: TableListComponent(
        label: '',
        onSubmit: (){},
        search: valueSearchEmployee,
        function: () {
          screenStack.popScreen();
          bloc.add(ChangeWidgetEvent());
        },
        buttonsNum: 1,
        media: media,
        widgetButtons: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            TableListButtonsAppBar(
              text: 'إضافة مادة',
              function: () {
                screenStack.pushScreen(
                    screen: const AddSubjectPage(), title: "إضافة مادة");
                bloc.add(ChangeWidgetEvent());
              },
            )
          ],
        ),
        widgetPage: SubjectsListBody(media: media),
      ),
    );
  }
}
