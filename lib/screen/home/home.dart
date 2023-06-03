import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/controller/filltretion_controller.dart';
import 'package:money_app/controller/transaction_controller.dart';

import 'package:money_app/db_function/user_name_db.dart';
import 'package:money_app/model/catagory_data_model.dart';

import 'package:money_app/screen/category/category.dart';
import 'package:money_app/screen/home/user_name/edit_user_name.dart';
import 'package:money_app/screen/navigator.dart';
import 'package:money_app/screen/transaction/transaction_delete_popup.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final transactionController = Get.put(TransactionController());
  final filterCT = Get.put(FiltretionController());
  final TransactionController transactionCT = TransactionController();
  final EditUserName eun = EditUserName();
  @override
  void initState() {
    transactionCT.refreshTransactionHome();
    UserNameDB.instance.getUserName();
    filterCT.filterControllerFunction();
    getBalance();
    UserNameDB.instance.userNameNotifier.value;
    log(UserNameDB.instance.userNameNotifier.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 233, 233),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leadingWidth: 1000,
          leading: Column(
            children: [
              const Text(
                'Welcome,',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  eun.editUserName(context, 'change your name');
                },
                child: Text(
                  UserNameDB.instance.userNameNotifier.value.username,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 213, 213, 213),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: GetBuilder<TransactionController>(
        builder: (controller) {
          getBalance();
          UserNameDB.instance.getUserName();
          UserNameDB.instance.userNameNotifier.value;
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/image/Home_screen (1).png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.10,
                  ),
                  Container(
                    width: width * 0.9,
                    height: height * 0.25,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.greenAccent, Colors.lightGreen],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.035,
                        ),
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
                        Text(
                          totalBalance.toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.arrow_upward_rounded,
                                        size: 32,
                                      ),
                                      Text(
                                        totalIncome.toString(),
                                        style: const TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.arrow_downward_rounded,
                                        size: 32,
                                      ),
                                      Text(
                                        totalExpense.toString(),
                                        style: const TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transaction',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ScreenCategory());
                          },
                          child: const Text(
                            'See all category',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Expanded(
                    child: CustomCard(
                      color: const Color.fromARGB(255, 216, 212, 212),
                      borderRadius: 20,
                      width: double.infinity,
                      child: transactionController.homeList.isEmpty
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
                            padding: EdgeInsets.zero,
                              itemBuilder: (ctx, index) {
                                final data =
                                    transactionController.homeList[index];
                                return Slidable(
                                  startActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                          onPressed: (ctx) {
                                            tD.showTransactionDelete(
                                                context, data);
                                          },
                                          icon: Icons.delete,
                                          label: 'delete',
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
                                          color:
                                              data.type == CategoryType.income
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                return SizedBox(
                                  height: height * 0.02,
                                );
                              },
                              itemCount: transactionController.homeList.length,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getBalance() async {
    totalBalance = 0.0;
    totalIncome = 0.0;
    totalExpense = 0.0;
    for (var element in transactionController.homeList) {
      if (element.type == CategoryType.income) {
        totalBalance += element.amount;
        totalIncome += element.amount;
      } else {
        totalBalance -= element.amount;
        totalExpense += element.amount;
      }
    }
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
