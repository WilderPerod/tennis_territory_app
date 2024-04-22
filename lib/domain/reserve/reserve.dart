class Reserve {
  String? id;
  final String courtId;
  final DateTime date;
  String? precipProb;
  final String userName;

  Reserve({
    this.id,
    required this.courtId,
    required this.date,
    this.precipProb,
    required this.userName,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) {
    return Reserve(
      id: json['id'].toString(),
      courtId: json['courtId'],
      date: DateTime.parse(json['date']),
      precipProb: json['precipProb'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtId': courtId,
      'date': date.toIso8601String(),
      'userName': userName,
    };
  }
}
