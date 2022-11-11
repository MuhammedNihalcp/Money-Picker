import 'package:flutter/material.dart';

import 'package:money_app/db_function/transaction_db.dart';

class TransactionFilterBar extends StatefulWidget {
  const TransactionFilterBar({super.key});

  @override
  State<TransactionFilterBar> createState() => _TransactionFilterBarState();
}

class _TransactionFilterBarState extends State<TransactionFilterBar> {
  final List<String> items = [
    'All',
    'Today',
    'Yesterday',
    'Week',
    'Month',
  ];
  late int selFilterIndex;
  @override
  void initState() {
    selFilterIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setFilter(items[index]);
                      setState(() {
                        selFilterIndex = index;
                      });
                    },
                    child: Card(
                        color: selFilterIndex == index
                            ? const Color(0xFFF3f3f3)
                            : Colors.white,
                        margin: selFilterIndex == index
                            ? const EdgeInsets.only(top: 10)
                            : const EdgeInsets.only(bottom: 5),
                        shape: const RoundedRectangleBorder(),
                        elevation: selFilterIndex == index ? 0 : 2,
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 100),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selFilterIndex == index
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            ),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  setFilter(var selction) async {
    final DateTime now = DateTime.now();
    switch (selction) {
      case 'All':
        TransactionDB.instance.clearFilter();
        break;
      case 'Today':
        DateTime start = DateTime(now.year, now.month, now.day);
        DateTime end = start.add(const Duration(days: 1));
        TransactionDB.instance.setFilter(start, end);
        break;
      case 'Yesterday':
        DateTime start = DateTime(now.year, now.month, now.day - 1);
        DateTime end = start.add(const Duration(days: 1));
        TransactionDB.instance.setFilter(start, end);
        break;
      case 'Week':
        DateTime start = DateTime(now.year, now.month, now.day - 6);
        DateTime end = DateTime(start.year, start.month, start.day + 7);
        TransactionDB.instance.setFilter(start, end);
        break;
      case 'Month':
        TransactionDB.instance.transactionPickDate(context);
        break;

      default:
        break;
    }
  }
}
