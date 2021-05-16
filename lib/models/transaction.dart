import 'package:flutter/foundation.dart';

class Transaction {
  @required
  final String id;
  @required
  final String title;
  @required
  final double price;
  @required
  final DateTime date;
  Transaction({this.id, this.title, this.price, this.date});
}
