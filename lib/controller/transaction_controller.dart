import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_app/db_function/transaction_db.dart';
import 'package:money_app/model/transaction_data_model.dart';
import 'package:month_year_picker/month_year_picker.dart';

class TransactionController extends GetxController {
  @override
  void onInit() {
    refreshTransactionHome();
    refreshTransaction();
    super.onInit();
  }

  late List<TransactionModel> filterList;
  late List<TransactionModel> list;
  List<TransactionModel> homeList = [];
  late List<TransactionModel> transactionList;
  bool isFilterEnable = false;
  late DateTime startDate;
  late DateTime endDate;
  TransactionController() {
    refreshTransaction();
    refreshTransactionHome();
  }
  addTransaction(TransactionModel model) async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    box.put(model.id, model);
    refreshTransaction();
    refreshTransactionHome();
    update();
  }

  updateTransaction(int id, TransactionModel model) async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    box.put(id, model);
    refreshTransaction();
    refreshTransactionHome();
    update();
  }

  deleteTransaction(String id) async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    box.delete(id);
    refreshTransaction();
    refreshTransactionHome();
    update();
  }

  restartTransaction() async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    box.clear();
  }

  refreshTransaction() async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    list = box.values.toList();
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
  }

  refreshTransactionHome() async {
    homeList = await getAllTransaction();
    homeList.sort((first, second) => second.date.compareTo(first.date));
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    final box = await Hive.openBox<TransactionModel>(transactionDbName);
    return Future.value(box.values.toList());
  }

  setFilter(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    isFilterEnable = true;
    refreshTransaction();
    update();
  }

  clearFilter() {
    isFilterEnable = false;
    refreshTransaction();
    update();
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
