import 'dart:convert';

class DaysTicketDto {
  final int id;
  final String description;
  final String abbreviation;

  DaysTicketDto({
    required this.id,
    required this.description,
    required this.abbreviation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'abbreviation': abbreviation,
    };
  }

  factory DaysTicketDto.fromMap(Map<String, dynamic> map) {
    return DaysTicketDto(
      id: map['id'] as int,
      description: map['description'] as String,
      abbreviation: map['abbreviation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DaysTicketDto.fromJson(String source) => DaysTicketDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
