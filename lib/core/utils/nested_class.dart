import 'package:flutter/material.dart';


@immutable
class Section {
    const Section(this.title, this.items);

    final String title;

    final List<String> items;
}

@immutable
abstract class Row {}

class HeaderRow implements Row {
  final String title;
  HeaderRow(this.title);
}

class ItemRow implements Row {
  final String description;
  final String total;

  ItemRow(this.description, this.total);
}
