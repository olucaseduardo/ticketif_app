// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:project_ifma_ticket/features/models/tables_model.dart';

class ListTablesModel {
  final List<TablesModel> meals;
  final List<TablesModel> justifications;
  
  ListTablesModel({
    required this.meals,
    required this.justifications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'meals': meals.map((x) => x.toMap()).toList(),
      'justifications': justifications.map((x) => x.toMap()).toList(),
    };
  }

  factory ListTablesModel.fromMap(Map<String, dynamic> map) {
    return ListTablesModel(
      meals: List<TablesModel>.from((map['meals'] as List<int>).map<TablesModel>((x) => TablesModel.fromMap(x as Map<String,dynamic>),),),
      justifications: List<TablesModel>.from((map['justifications'] as List<int>).map<TablesModel>((x) => TablesModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListTablesModel.fromJson(String source) => ListTablesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
