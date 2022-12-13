import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_app/controller/category_controller.dart';
import 'package:money_app/controller/filltretion_controller.dart';

import 'package:money_app/controller/transaction_controller.dart';
import 'package:money_app/db_function/catagory_db.dart';

import 'package:money_app/model/catagory_data_model.dart';
import 'package:money_app/model/transaction_data_model.dart';
import 'package:money_app/screen/category/category.dart';
import 'package:money_app/screen/navigator.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CatagoryModel? selectedCategoryModel;
  String? categoryID;
  final TextEditingController amountEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TransactionController transactionCT = Get.find();
  final transactionController = Get.put(TransactionController());
  final categoryController = Get.put(CategoryController());
  final filtertionController = Get.put(FiltretionController());
  // final FiltretionController filtretionCT = Get.find();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    categoryController.refreshCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 200, 200),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: const Image(
            image: AssetImage('lib/assets/image/Home_screen.png'),
            fit: BoxFit.fill,
          ),
          backgroundColor: const Color.fromARGB(141, 56, 214, 61),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.2),
            child: const Text(
              'Add Transaction',
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
          padding: EdgeInsets.all(height * 0.02),
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
                    colors: [Colors.greenAccent, Colors.lightGreen],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.02),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.020,
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
                          height: height * 0.025,
                        ),
                        TextButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              fixedSize: MaterialStateProperty.all(
                                  Size(width * 0.85, height * 0.09)),
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
                              selectedDate == null
                                  ? parseDate(DateTime.now())
                                  : parseDate(selectedDate!),
                              style: const TextStyle(color: Colors.black),
                            )),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  Get.to(() => const ScreenCategory());
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.black,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.category_rounded,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                            dropdownColor:
                                const Color.fromARGB(255, 172, 229, 189),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(10),
                            hint: const Text('Select Category'),
                            value: categoryID,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Category Items is Empty';
                              } else {
                                return null;
                              }
                            },
                            items: (selectedCategoryType == CategoryType.income
                                    ? categoryController.incomeCategory
                                    : categoryController.expenseCategory)
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
                              });
                            }),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount value is empty';
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
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
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
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            minimumSize: MaterialStateProperty.all(
                                Size(width * 0.85, height * 0.09)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              transactionAdd();
                            } else {
                              Get.snackbar(
                                'Error',
                                'Warning: Form is Empty !!!',
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(10),
                              );
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
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

  Future<void> transactionAdd() async {
    final amountText = amountEditingController.text.trim();

    if (selectedDate == null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
      type: selectedCategoryType!,
      catagory: selectedCategoryModel!,
      date: selectedDate!,
      amount: parsedAmount,
    );
    transactionController.addTransaction(model);
    filtertionController.filterControllerFunction();
    Get.offAll(() => const ScreenNavigator());
    // filtretionCT.filterControllerFunction();
    transactionController.refreshTransaction();
    transactionController.refreshTransactionHome();

    Get.snackbar(
      '',
      'Transaction added succefully ✓',
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.green,
      margin: const EdgeInsets.all(10),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
