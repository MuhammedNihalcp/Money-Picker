// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:money_app/model/catagory_data_model.dart';
// import 'package:money_app/model/transaction_data_model.dart';

// class HiveImpl extends AddEditService with ChangeNotifier {
//   HiveImpl() {
//     refreshUi();
//   }

//   final String dbName = 'Tmodeldb';
//   List<TransactionModel> incomeList = [];
//   List<TransactionModel> expenceList = [];
//   List<TransactionModel> borrowList = [];
//   List<TransactionModel> lendList = [];
//   List<TransactionModel> recentList = [];

//   @override
//   Future<void> addDetails(TransactionModel value) async {
//     final obj = await Hive.openBox<TransactionModel>(dbName);
//     obj.put(value.id, value);
//     await getDeatails();
//   }

//   @override
//   Future<void> deleteDetails(String id) async {
//     final obj = await Hive.openBox<TransactionModel>(dbName);
//     obj.delete(id);
//   }

//   @override
//   Future<List<TransactionModel>> getDeatails() async {
//     final obj = await Hive.openBox<TransactionModel>(dbName);
//     return obj.values.toList();
//   }

//   @override
//   Future<void> updataeDetails(TransactionModel value) async {
//     final obj = await Hive.openBox<TransactionModel>(dbName);
//     obj.put(value.id, value);
//   }

//   double recentTotal = 0;
//   double expenseTotal = 0;
//   double incomeTotal = 0;
//   double lendTotal = 0;
//   double borrowTotal = 0;

//   refreshUi() async {
//     recentTotal = 0;
//     expenseTotal = 0;
//     incomeTotal = 0;
//     lendTotal = 0;
//     borrowTotal = 0;
//     recentList.clear();
//     incomeList.clear();
//     expenceList.clear();
//     borrowList.clear();
//     lendList.clear();
//     final data = await getDeatails();
//     recentList.addAll(data);
//     Future.forEach(data, (TransactionModel dbValues) {
//       recentTotal = recentTotal + dbValues.amount;
//       if (dbValues.type == CategoryType.borrow) {
//         borrowTotal = borrowTotal + dbValues.amount;
//         borrowList.add(dbValues);
//       } else if (dbValues.type == CategoryType.lend) {
//         lendTotal = lendTotal + dbValues.amount;
//         lendList.add(dbValues);
//       } else if (dbValues.type == CategoryType.income) {
//         incomeTotal = incomeTotal + dbValues.amount;
//         incomeList.add(dbValues);
//       } else if (dbValues.type == CategoryType.expense) {
//         expenseTotal = expenseTotal + dbValues.amount;
//         expenceList.add(dbValues);
//       }
//     });

//     recentTotal = (incomeTotal + lendTotal) - (borrowTotal + expenseTotal);

//     notifyListeners();
//   }
// }