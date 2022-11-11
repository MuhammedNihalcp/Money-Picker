import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:money_app/db_function/catagory_db.dart';
import 'package:money_app/db_function/filteration_db.dart';
import 'package:money_app/db_function/transaction_db.dart';

import 'package:money_app/model/catagory_data_model.dart';
import 'package:money_app/model/transaction_data_model.dart';

// ignore: must_be_immutable
class ScreenEdit extends StatefulWidget {
  ScreenEdit(
      {Key? key,
      required this.amount,
      required this.catagory,
      required this.date,
      required this.type,
      required this.index})
      : super(key: key);
  final double amount;
  final CategoryType type;
  final CatagoryModel catagory;
  final DateTime date;
  int index;

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  late DateTime selectedDate;
  late CategoryType selectedCategoryType;
  late CatagoryModel selectedCategoryModel;
  late TextEditingController amountEditingController;
  late String selectedCategoryitem;
  late int categoryIndex;
  String? categoryID;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    amountEditingController =
        TextEditingController(text: widget.amount.toString());
    selectedCategoryType = widget.type;
    selectedCategoryitem = widget.catagory.name;
    selectedDate = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.15),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          flexibleSpace: const Image(
            image: AssetImage('lib/assets/image/Home_screen.png'),
            fit: BoxFit.fill,
          ),
          backgroundColor: const Color.fromARGB(141, 56, 214, 61),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Text(
              'Edit Transaction',
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
          padding: EdgeInsets.all(height * 0.015),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                width: width * 0.95,
                height: height * 0.7,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF69F0AE), Colors.lightGreen],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.015),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.035,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.black,
                                  value: CategoryType.income,
                                  groupValue: selectedCategoryType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategoryType =
                                          CategoryType.income;
                                      categoryID = null;
                                    });
                                  },
                                ),
                                const Text('Income')
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.black,
                                  value: CategoryType.expense,
                                  groupValue: selectedCategoryType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategoryType =
                                          CategoryType.expense;
                                      categoryID = null;
                                    });
                                  },
                                ),
                                const Text('Expense')
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(330, 60)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final selectedDateTemp = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 30)),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDateTemp == null) {
                                return;
                              } else {
                                setState(() {
                                  selectedDate = selectedDateTemp;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.black,
                            ),
                            label: Text(
                              parseDate(selectedDate),
                              style: const TextStyle(color: Colors.black),
                            )),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.category_rounded,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                            ),
                            dropdownColor: Colors.green,
                            elevation: 0,
                            borderRadius: BorderRadius.circular(100),
                            isExpanded: true,
                            hint: Text(selectedCategoryitem.isEmpty
                                ? 'Select Category'
                                : selectedCategoryitem),
                            value: categoryID,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Category is Empty';
                              } else {
                                return null;
                              }
                            },
                            items: (selectedCategoryType == CategoryType.income
                                    ? CategoryDB().incomeCategoryNotifier
                                    : CategoryDB().expenseCategoryNotifier)
                                .value
                                .map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                                onTap: () {
                                  selectedCategoryModel = e;
                                },
                              );
                            }).toList(),
                            onChanged: (selectValue) {
                              setState(() {
                                categoryID = selectValue;
                                selectedCategoryitem = selectValue!;
                              });
                            }),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount is empty';
                            } else {
                              return null;
                            }
                          },
                          controller: amountEditingController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Amount',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(320, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              save(context);
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save(ctx) async {
    // ScaffoldMessenger.of(ctx).showSnackBar(
    //   const SnackBar(
    //     backgroundColor: Colors.green,
    //     behavior: SnackBarBehavior.floating,
    //     duration: Duration(seconds: 2),
    //     content: Text('Saving Your Trasaction'),
    //   ),
    // );
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final amountText = amountEditingController.text.toString();
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }
    final transactionModel = TransactionModel(
      type: selectedCategoryType,
      catagory: selectedCategoryModel,
      date: selectedDate,
      amount: parsedAmount,
    );

    TransactionDB.instance.updateTransaction(widget.index, transactionModel);
    if (!mounted) {
      return;
    }
    filterFunction();
    
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
    TransactionDB.instance.refreshHome();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        content: Text("Transaction update succefully  ✓")));
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
