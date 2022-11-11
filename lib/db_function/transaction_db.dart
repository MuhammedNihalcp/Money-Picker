import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/model/transaction_data_model.dart';
import 'package:month_year_picker/month_year_picker.dart';

const transactionDbName = 'transactionDB';

abstract class TransactionDbFuntion {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(int id, TransactionModel value);
  Future<void> restartTransaction();
}

class TransactionDB implements TransactionDbFuntion {
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  late List<TransactionModel> filterList;
  late List<TransactionModel> list;
  late List<TransactionModel> homeList;
  late List<TransactionModel> transactionList;
  bool isFilterEnable = false;
  late DateTime startDate;
  late DateTime endDate;
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> transactionhomeListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionDB.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    list = transactionDB.values.toList();
    if (isFilterEnable) {
      filterList = list
          .where((element) =>
              (element.date.isAfter(startDate) || element.date == startDate) &&
              element.date.isBefore(endDate))
          .toList();
    } else {
      filterList = list;
    }
    filterList.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(filterList);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    transactionListNotifier.notifyListeners();
  }

  Future<void> refreshHome() async {
    final homeList = await getAllTransaction();
    homeList.sort((first, second) => second.date.compareTo(first.date));
    transactionhomeListNotifier.value.clear();
    transactionhomeListNotifier.value.addAll(homeList);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionhomeListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);

    return transactionDB.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.delete(id);

    refresh();
    refreshHome();
  }

  @override
  Future<void> updateTransaction(int id, TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.putAt(id, value);
    refresh();
    refreshHome();
  }

  @override
  Future<void> restartTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.clear();
  }

  setFilter(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    isFilterEnable = true;
    refresh();
  }

  clearFilter() {
    isFilterEnable = false;
    refresh();
  }

  DateTime selectedmonth = DateTime.now();

  transactionPickDate(context) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedmonth,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    selectedmonth = selected!;
    DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
    DateTime end = DateTime(start.year, start.month + 1, start.day);
    setFilter(start, end);
  }
}
