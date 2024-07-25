import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

import '../../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../../core/widgets/table_screen/icons_options.dart';
import '../../../data/models/room_category_model.dart';
import '../../../data/models/room_category_model_list.dart';
import '../../bloc/list/list_categories_bloc/list_categories_bloc.dart';

class ItemBuilderCategory extends StatelessWidget {
  const ItemBuilderCategory({
    super.key,
    required this.bloc,
    required this.state,
    required this.categories,
  });

  final ListCategoriesBloc bloc;
  final ListCategoriesStates state;
  final RoomCategoryModelList categories;

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListCategoriesSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: categories.data?.length,
                itemBuilder: (context, index) {
                  final RoomOrCategoryModel? category = categories.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () { },
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('   ${category?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 12,
                              child: Center(
                                child: Text('${category?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),

                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: category,
                              checkBox: (newValue) {
                                BlocProvider.of<ListCategoriesBloc>(context)
                                    .add(CheckboxEvent());
                                category?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.categories.add(value);
                                }
                              },
                              delete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                alertDialogGeneral(
                                  title: "هل أنت متأكد من حذف هذا العنصر",
                                  context: context,
                                  submitFunction: () {
                                    BlocProvider.of<ListCategoriesBloc>(context)
                                        .add(DeleteCategoryEvent(
                                            indexCategory: category!.id!));
                                    BlocProvider.of<ListCategoriesBloc>(context)
                                        .add(CategoriesEvents(
                                            currentPage: bloc.currentPage));
                                  },
                                );
                              },
                              edit: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : state is ListCategoriesFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                :   const Center( child: CircularProgressIndicator(),  ));
  }
}
