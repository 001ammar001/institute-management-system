import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../bloc/list/list_categories_bloc/list_categories_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart' as getit;

import '../../widgets/category_list_widgets/category_list_pages.dart';
import '../add_room_category_page.dart';

TextEditingController valueSearchCategory = TextEditingController();

class ShowCategoriesScreen extends StatelessWidget {
  const ShowCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<ListCategoriesBloc>()..add(const CategoriesEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchCategory,
          function: () {
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 2,
          media: media,
          widgetButtons: Row(
            children: [
              TableListButtonsAppBar(
                function: () {

                },
                text: 'الفلاتر',
              ),
              const SizedBox(
                width: 20,
              ),
              TableListButtonsAppBar(
                function: () {
                  screenStack.pushScreen(
                      screen: const AddRoomOrCategoryPage(
                          type: SearchTypeEnum.category),
                      title: "إضافة تصنيف ");
                  bloc.add(ChangeWidgetEvent());
                },
                text: 'إضافة تصنيف',
              ),

            ],
          ),
          widgetPage: CategoryListPageState(media: media),
        ),
      ),
    );
  }
}
