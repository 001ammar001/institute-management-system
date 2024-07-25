import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../core/widgets/table_screen/icons_options.dart';
import '../../domain/entites/role_entity.dart';
import '../../domain/entites/role_list_entity.dart';
import '../bloc/list_roles_bloc/list_role_bloc.dart';

class ItemBuilderRole extends StatelessWidget {
  const ItemBuilderRole({
    super.key,
    required this.bloc,
    required this.state,
    required this.roleList,
  });

  final ListRolesBloc bloc;
  final ListRolesStates state;
  final RoleListEntity roleList;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListRolesSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: roleList.roles?.length,
                itemBuilder: (context, index) {
                  final RoleEntity? role = roleList.roles?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return Container(
                    color: backgroundColor,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text('   ${role?.id}',
                                style: const TextStyle(color: textColor))),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Text('${role?.name}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                  )),
                            )),
                        Expanded(
                            flex: 6,
                            child: Center(
                              child: Text(
                                bloc.roles.roles![index].permissions
                                    .join(",\t"),
                                style: const TextStyle(
                                    color: textColor, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: IconsRowOptions(
                            item: role,
                            checkBox: (newValue) {
                              BlocProvider.of<ListRolesBloc>(context)
                                  .add(CheckboxEvent());
                              role?.index = newValue!;
                              if (newValue!) {
                                //Bloc.roles.add(value);
                              }
                            },
                            delete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              alertDialogGeneral(
                                title: "هل أنت متأكد من حذف هذا العنصر",
                                context: context,
                                submitFunction: () {
                                  BlocProvider.of<ListRolesBloc>(context).add(
                                      DeleteRoleEvent(indexRole: role!.id!));
                                  BlocProvider.of<ListRolesBloc>(context).add(
                                      RolesEvents(
                                          currentPage: bloc.currentPage));
                                },
                              );
                            },
                            edit: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                })
            : state is ListRolesFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
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
