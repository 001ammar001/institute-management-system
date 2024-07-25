class ImportExportEntity {
  final int id;
  final int amount;

  ImportExportEntity({required this.id, required this.amount});

  Map<String, dynamic> toJson() {
    return {"amount": amount};
  }
}
