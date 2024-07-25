class ExtraEventDetails {
  final int id;
  final String room;
  final String createdAt;

  ExtraEventDetails({
    required this.id,
    required this.room,
    required this.createdAt,
  });

  factory ExtraEventDetails.fromJson(Map<String, dynamic> json) {
    return ExtraEventDetails(
      id: json["id"],
      room: json["room"],
      createdAt: json["created_at"],
    );
  }
}
