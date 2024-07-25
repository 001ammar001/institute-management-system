import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/features/search/presentation/bloc/search_dialog_bloc/search_dialog_bloc.dart';

class CustomSearchbar extends StatelessWidget {
  final SearchTypeEnum searchFor;
  final TextEditingController searchController;

  const CustomSearchbar({
    super.key,
    required this.searchController,
    required this.searchFor,
  });

  void onSearch(context) {
    if (searchController.text.isNotEmpty &&
        searchController.text.trim().isNotEmpty) {
      BlocProvider.of<SearchBloc>(context).add(
        SearchForEntitysEvents(
          query: searchController.text,
          type: searchFor.getEndPoint(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      hintText: "ابحث عن ${searchFor.getArabicName()}",
      onChanged: (value) {
        searchController.text = value;
        onSearch(context);
      },
      onSubmitted: (value) {
        onSearch(context);
      },
      trailing: [
        IconButton(
          onPressed: () {
            onSearch(context);
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }
}
