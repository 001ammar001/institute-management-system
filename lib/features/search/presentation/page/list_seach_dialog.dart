import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/add_new_item_button.dart';
import 'package:institute_management_system/features/search/presentation/widgets/custom_searchbar.dart';
import 'package:institute_management_system/features/search/presentation/bloc/search_dialog_bloc/search_dialog_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/search/presentation/widgets/search_results.dart';

class ListSearchDialogForm extends StatefulWidget {
  const ListSearchDialogForm(
      {super.key, required this.searchType, required this.add});

  final SearchTypeEnum searchType;
  final Function add;

  @override
  State<ListSearchDialogForm> createState() => ListSearchDialogFormState();
}

class ListSearchDialogFormState extends State<ListSearchDialogForm> {
  late TextEditingController searchController;
  ListSearchDialogFormState();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) => getit.sl<SearchBloc>()
            ..add(InitialSearchEvents(type: widget.searchType.getEndPoint())),
          child: BuildDialogBody(
            searchController: searchController,
            searchType: widget.searchType,
            add: widget.add,
          ),
        ),
      ),
    );
  }
}

class BuildDialogBody extends StatelessWidget {
  const BuildDialogBody(
      {super.key,
      required this.searchController,
      required this.searchType,
      required this.add});

  final TextEditingController searchController;
  final SearchTypeEnum searchType;
  final Function add;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchbar(
          searchFor: searchType,
          searchController: searchController,
        ),
        const SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchDialogStates>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchSucessState) {
                if (state.results.isEmpty) {
                  return const Center(
                    child: Text("لا يوجد بيانات"),
                  );
                }
                return SearchResults(state: state);
              }
              return const Center(child: Text("حدث خطأ يرجى المحاولة لاحقا"));
            },
          ),
        ),
        AddButton(
          label: searchType.getArabicName(),
          add: add,
        ),
      ],
    );
  }
}
