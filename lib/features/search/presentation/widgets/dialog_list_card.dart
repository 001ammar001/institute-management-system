import 'package:flutter/material.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class SearchListCard extends StatelessWidget {
  final int id;
  final String name;

  const SearchListCard({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, SearchEntity(id: id, name: name));
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            name,
          ),
        ),
      ),
    );
  }
}
