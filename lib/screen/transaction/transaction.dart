import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/db_function/filteration_db.dart';

import 'package:money_app/db_function/transaction_db.dart';
import 'package:money_app/model/catagory_data_model.dart';

import 'package:money_app/screen/transaction/edit_transaction.dart';
import 'package:money_app/screen/transaction/transaction_delete_popup.dart';
import 'package:money_app/screen/transaction/transaction_filters.dart';

import '../../model/transaction_data_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    // TransactionDB.instance.transactionPickDate(context);
    filterFunction();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const Image(
            image: AssetImage('lib/assets/image/Home_screen.png'),
            fit: BoxFit.fill,
          ),
          backgroundColor: const Color.fromARGB(141, 56, 214, 61),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Text(
              'Transaction',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(height * 0.01),
          child: Column(
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 229, 225, 225)),
                  fixedSize: MaterialStateProperty.all(const Size(330, 40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                onPressed: () {
                  showSearch(context: context, delegate: CustomSerchDelegate());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                label: const Text(
                  '  Search Items',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
               SizedBox(
                height: height * 0.01,
              ),
              const TransactionFilterBar(),
               SizedBox(
                height: height * 0.02,
              ),
              CustomCard(
                elevation: 0,
                color: const Color.fromARGB(255, 216, 212, 212),
                width: widht * 0.92,
                height: height * 0.56,
                borderRadius: 20,
                child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (BuildContext ctx,
                      List<TransactionModel> transactionList, Widget? _) {
                    return TransactionDB
                            .instance.transactionListNotifier.value.isEmpty
                        ? Stack(
                            children: [
                              Center(
                                child: Text(
                                  'No Data Available',
                                  style: GoogleFonts.anton(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 27, 88, 83),
                                  ),
                                ),
                              ),
                              Center(
                                child: Lottie.asset(
                                  'lib/assets/image/lotties/lf20_jyguxb6d.json',
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            itemBuilder: (ctx, index) {
                              final data = transactionList[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.black,
                                        onPressed: (ctx) {
                                          showTransactionDelete(context, data);
                                        },
                                        icon: Icons.delete,
                                        label: 'delete',
                                      )
                                    ]),
                                endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        onPressed: (ctx) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => ScreenEdit(
                                                amount: data.amount,
                                                catagory: data.catagory,
                                                date: data.date,
                                                type: data.type,
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icons.edit,
                                        foregroundColor: Colors.black,
                                        label: 'Edit',
                                      )
                                    ]),
                                key: Key(data.id!),
                                child: CustomCard(
                                  borderRadius: 100,
                                  child: ListTile(
                                    leading: data.type == CategoryType.income
                                        ? const Icon(
                                            Icons.arrow_circle_up_outlined,
                                            color: Colors.black,
                                            size: 35,
                                          )
                                        : const Icon(
                                            Icons.arrow_circle_down_outlined,
                                            color: Colors.black,
                                            size: 35,
                                          ),
                                    title: Text(data.catagory.name),
                                    subtitle: Text(
                                      data.type.name,
                                      style: TextStyle(
                                        color: data.type == CategoryType.income
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹ ${data.amount.toString()}',
                                            style: TextStyle(
                                              color: data.type ==
                                                      CategoryType.income
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                           SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(parseDate(data.date))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return  SizedBox(
                                height: height * 0.02,
                              );
                            },
                            itemCount: transactionList.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}

class CustomSerchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear_outlined,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> transactionList,
          Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: CustomCard(
                elevation: 0,
                color: const Color.fromARGB(255, 216, 212, 212),
                width: width * 0.98,
                height: height * 0.96,
                borderRadius: 20,
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = transactionList[index];
                    if (data.catagory.name
                        .toLowerCase()
                        .contains(query.toLowerCase())) {
                      return Column(
                        children: [
                          CustomCard(
                            borderRadius: 100,
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: data.type ==
                                          CategoryType.income
                                      ? const AssetImage(
                                          'lib/assets/image/arrow upwarp.png')
                                      : const AssetImage(
                                          'lib/assets/image/arrow downward.png')),
                              title: Text(data.catagory.name),
                              subtitle: Text(
                                data.type.name,
                                style: TextStyle(
                                  color: data.type == CategoryType.income
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '₹ ${data.amount.toString()}',
                                      style: TextStyle(
                                        color: data.type == CategoryType.income
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(parseDate(data.date))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox();
                  },
                  itemCount: transactionList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> transactiontList,
          Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: CustomCard(
                elevation: 0,
                color: const Color.fromARGB(255, 216, 212, 212),
                width: width * 0.98,
                height: height * 0.96,
                borderRadius: 20,
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = transactiontList[index];
                    if (data.catagory.name
                        .toLowerCase()
                        .contains(query.toLowerCase())) {
                      return Column(
                        children: [
                          CustomCard(
                            borderRadius: 100,
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: data.type ==
                                          CategoryType.income
                                      ? const AssetImage(
                                          'lib/assets/image/arrow upwarp.png')
                                      : const AssetImage(
                                          'lib/assets/image/arrow downward.png')),
                              title: Text(data.catagory.name),
                              subtitle: Text(
                                data.type.name,
                                style: TextStyle(
                                  color: data.type == CategoryType.income
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '₹ ${data.amount.toString()}',
                                      style: TextStyle(
                                        color: data.type == CategoryType.income
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(parseDate(data.date))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox();
                  },
                  itemCount: transactiontList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
