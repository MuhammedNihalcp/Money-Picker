import 'package:hive_flutter/adapters.dart';
import 'package:money_app/model/catagory_data_model.dart';
part 'transaction_data_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final CategoryType type;
  @HiveField(2)
  final CatagoryModel catagory;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final double amount;

  TransactionModel(
      {required this.type,
      required this.catagory,
      required this.date,
      required this.amount,
     }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
