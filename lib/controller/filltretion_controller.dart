import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_app/controller/transaction_controller.dart';

import '../model/catagory_data_model.dart';
import '../model/transaction_data_model.dart';

class FiltretionController extends GetxController {
  FiltretionController._internal();
  static FiltretionController instance = FiltretionController._internal();
  factory FiltretionController() {
    return instance;
  }
  List<TransactionModel> overviewNotifier = [];
  List<TransactionModel> incomeNotifier = [];

  List<TransactionModel> expenseNotifier = [];

  List<TransactionModel> todayNotifier = [];

  List<TransactionModel> yesterdayNotifier = [];

  List<TransactionModel> incomeTodayNotifier = [];

  List<TransactionModel> incomeYesterdayNotifier = ([]);

  List<TransactionModel> expenseTodayNotifier = [];

  List<TransactionModel> expenseYesterdayNotifier = [];
  List<TransactionModel> lastWeekNotifier = [];

  List<TransactionModel> incomeLastWeekNotifier = [];

  List<TransactionModel> expenseLastWeekNotifier = [];

  List<TransactionModel> lastMonthNotifier = ([]);

  List<TransactionModel> incomeLastMonthNotifier = [];

  List<TransactionModel> expenseLastMonthNotifier = [];
  String today = DateFormat.yMd().format(
    DateTime.now(),
  );
  String yesterday = DateFormat.yMd().format(
    DateTime.now().subtract(
      const Duration(days: 1),
    ),
  );
  final transactionController = TransactionController();
  filterControllerFunction() async {
    final list = await transactionController.getAllTransaction();
    overviewNotifier.clear();
    incomeNotifier.clear();
    expenseNotifier.clear();
    todayNotifier.clear();
    yesterdayNotifier.clear();
    incomeTodayNotifier.clear();
    incomeYesterdayNotifier.clear();
    expenseTodayNotifier.clear();
    expenseYesterdayNotifier.clear();
    lastWeekNotifier.clear();
    expenseLastWeekNotifier.clear();
    incomeLastWeekNotifier.clear();
    lastMonthNotifier.clear();
    expenseLastMonthNotifier.clear();
    incomeLastMonthNotifier.clear();
    //allFliter
    for (var element in list) {
      if (element.type == CategoryType.income) {
        incomeNotifier.add(element);
        update();
      } else if (element.type == CategoryType.expense) {
        expenseNotifier.add(element);
        update();
      }
      overviewNotifier.add(element);
      update();
    }
    //nextFilter
    for (var element in list) {
      String elementDate = DateFormat.yMd().format(element.date);
      //todayFilter
      if (elementDate == today) {
        todayNotifier.add(element);
        update();
      }
      //yesterdayFilter
      if (elementDate == yesterday) {
        yesterdayNotifier.add(element);
        update();
      }
      //weekFilter
      if (element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      )) {
        lastWeekNotifier.add(element);
        update();
      }
      //monthFilter
      if (element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 30),
        ),
      )) {
        lastMonthNotifier.add(element);
        update();
      }

      if (elementDate == today && element.type == CategoryType.income) {
        incomeTodayNotifier.add(element);
        update();
      }

      if (elementDate == yesterday && element.type == CategoryType.income) {
        incomeYesterdayNotifier.add(element);
        update();
      }

      if (elementDate == today && element.type == CategoryType.expense) {
        expenseTodayNotifier.add(element);
        update();
      }

      if (elementDate == yesterday && element.type == CategoryType.expense) {
        expenseYesterdayNotifier.add(element);
        update();
      }
      if (element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ) &&
          element.type == CategoryType.income) {
        incomeLastWeekNotifier.add(element);
        update();
      }

      if (element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ) &&
          element.type == CategoryType.expense) {
        expenseLastWeekNotifier.add(element);
        update();
      }

      if (element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 30),
            ),
          ) &&
          element.type == CategoryType.income) {
        incomeLastMonthNotifier.add(element);
        update();
      }

      if (element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 30),
            ),
          ) &&
          element.type == CategoryType.expense) {
        expenseLastMonthNotifier.add(element);
        update();
      }
    }
  }
}
