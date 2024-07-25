import 'package:flutter/material.dart';
import 'package:institute_management_system/features/search/presentation/bloc/search_dialog_bloc/search_dialog_bloc.dart';
import 'package:institute_management_system/features/search/presentation/widgets/dialog_list_card.dart';

class SearchResults extends StatelessWidget {
  final SearchSucessState state;
  const SearchResults({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return SearchListCard(
                name: state.results[index].name,
                id: state.results[index].id,
              );
            },
          ),
        ),
      ],
    );
  }
}
