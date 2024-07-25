class ListEntity<T> {
  final int maxPage;
  final List<T> entitys;
  final List<bool> selecetdEntitys;
  ListEntity({required this.maxPage, required this.entitys})
      : selecetdEntitys = List.filled(entitys.length, false, growable: false);
}
