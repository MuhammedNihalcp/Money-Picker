import 'package:flutter/material.dart';
import 'package:money_app/db_function/filteration_db.dart';
import 'package:money_app/db_function/transaction_db.dart';
import 'package:money_app/db_function/user_name_db.dart';
import 'package:money_app/model/catagory_data_model.dart';
import 'package:money_app/screen/Transaction/add_transaction.dart';
import 'package:money_app/screen/Transaction/transaction.dart';
import 'package:money_app/screen/home/home.dart';
import 'package:money_app/screen/settings/settings.dart';
import 'package:money_app/screen/statics/grap.dart';

double totalBalance = 0.0;
double totalIncome = 0.0;
double totalExpense = 0.0;

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({super.key});

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final _page = [
    const ScreenHome(),
    const ScreenTransaction(),
    const Graphs(),
    const ScreenSettings(),
  ];

  int _currentSelectIndex = 0;
   @override
  void initState() {
    getBalance();
    filterFunction();
    UserNameDB.instance.getUserName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserNameDB.instance.getUserName();
    getBalance();
    return Scaffold(
      body: _page[_currentSelectIndex],
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 220, 217, 217),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          currentIndex: _currentSelectIndex,
          onTap: (newIndex) {
            setState(() {
              _currentSelectIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: 'Transaction'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline), label: 'Statistics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications), label: 'Settings')
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          // if (_currentSelectIndex == 2) {
          //   showCategoryAddPopup(context);
          // } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const ScreenAddTransaction()));
          // }
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

   void getBalance() async {
    totalBalance = 0.0;
    totalIncome = 0.0;
    totalExpense = 0.0;
    for (var element
        in TransactionDB.instance.transactionhomeListNotifier.value) {
      if (element.type == CategoryType.income) {
        setState(() {
          totalBalance = totalBalance + element.amount;
          totalIncome = totalIncome + element.amount;
        });
      } else {
        setState(() {
          totalBalance = totalBalance - element.amount;
          totalExpense = totalExpense + element.amount;
        });
      }
    }
  }
}
