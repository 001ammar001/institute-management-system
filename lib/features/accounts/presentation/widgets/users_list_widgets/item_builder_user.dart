import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/table_screen/icons_options.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/pages/user_details_page.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/edit_user_dialog.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class ItemBuilderUser extends StatelessWidget {
  const ItemBuilderUser({
    super.key,
    required this.bloc,
    required this.state,
    required this.users,
  });

  final ListUsersBloc bloc;
  final ListUsersStates state;
  final UserModelList users;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListUsersSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: users.data!.length,
                itemBuilder: (context, index) {
                  final User user = users.data![index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    onPressed: () {
                      screenStack.pushScreen(
                          screen: UserDetailsPage(user: user),
                          title: "تفاصيل الحساب");
                      drawerBloc.add(ChangeWidgetEvent());
                    },
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('   ${user.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${user.username}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${user.role?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text(
                                    user.employee?.name != null
                                        ? "${user.employee?.name}"
                                        : "لا يوجد",
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: user,
                              deleteIcon: bloc.getArchived
                                  ? Icons.restore_from_trash
                                  : Icons.delete,
                              deleteIconColor:
                                  bloc.getArchived ? Colors.green : Colors.red,
                              checkBox: (newValue) {
                                BlocProvider.of<ListUsersBloc>(context)
                                    .add(CheckboxEvent());
                                user.index = newValue!;
                              },
                              delete: () {
                                if (bloc.getArchived) {
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من استعادة هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      BlocProvider.of<ListUsersBloc>(context)
                                          .add(RestoreUserEvent(
                                              indexUser: user.id!));
                                    },
                                  );
                                } else {
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من حذف هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      BlocProvider.of<ListUsersBloc>(context)
                                          .add(DeleteUserEvent(
                                              indexUser: user.id!));
                                    },
                                  );
                                }
                              },
                              edit: () {
                                if (bloc.getArchived) {
                                  alertDialogGeneral(
                                    title: "لا يمكن تعديل عنصر محذوف",
                                    context: context,
                                    submitFunction: () {},
                                  );
                                } else {
                                  showEditUserDialog(context, user);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : state is ListUsersFailureState
                ? Center(
                    child: Text(
                      (state as ListUsersFailureState).message,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}

Future<dynamic> showEditUserDialog(BuildContext context, User user) {
  return showDialog(
    context: context,
    builder: (_) {
      final employee = SearchEntity(
        id: user.employee?.id,
        name: user.employee?.name,
      );

      final role = SearchEntity(
        id: user.role?.id,
        name: user.role?.name,
      );

      return UserEditDialog(
        role: role,
        employee: employee,
        onSubmit: () {
          final entity = User(
            id: user.id!,
            employee: Role(id: employee.id, name: employee.name),
            role: Role(id: role.id, name: role.name),
          );
          BlocProvider.of<ListUsersBloc>(context)
              .add(EditUserEvent(user: entity));
        },
      );
    },
  );
}
