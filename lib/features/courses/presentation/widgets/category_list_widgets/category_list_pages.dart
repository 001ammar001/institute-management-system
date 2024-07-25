import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/response_dialogs.dart';
import '../../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../bloc/list/list_categories_bloc/list_categories_bloc.dart';
import 'header_list_categories.dart';
import 'item_builder_category.dart';

class CategoryListPageState extends StatelessWidget {
  final Size media;

  const CategoryListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListCategoriesBloc bloc = BlocProvider.of<ListCategoriesBloc>(context);
    return BlocConsumer<ListCategoriesBloc, ListCategoriesStates>(
        listener: (context, state) {
      if (state is ListCategoriesSuccessState) {
        bloc.stateButtonArrowForwardCategory = 0;
        bloc.stateButtonArrowBackCategory = 0 ;
        bloc.stateButtonDeleteCategory=0;
      } else if (state is ListCategoriesFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteCategoriesFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListCategories(media: media),
            ItemBuilderCategory(
              bloc: bloc,
              state: state,
              categories: bloc.categories,
            ),
            ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                  if (bloc.stateButtonArrowBackCategory == 0) {
                    if (bloc.currentPage > 1) {
                      bloc.currentPage--;
                      BlocProvider.of<ListCategoriesBloc>(context)
                          .add(CategoriesEvents(currentPage: bloc.currentPage));
                    }
                    bloc.stateButtonArrowBackCategory++;
                  }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardCategory == 0) {
                  if (bloc.categories.meta!.currentPage! <
                      bloc.categories.meta!.lastPage!) {
                    bloc.currentPage++;
                    BlocProvider.of<ListCategoriesBloc>(context)
                        .add(CategoriesEvents(currentPage: bloc.currentPage));
                  }
                  bloc.stateButtonArrowForwardCategory++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
