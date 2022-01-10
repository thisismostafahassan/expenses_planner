import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final double price;
  final DateTime date;

  Transaction(
      {this.id,
      @required this.name,
      @required this.price,
      @required this.date});
}
