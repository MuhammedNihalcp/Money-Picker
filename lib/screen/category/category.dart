import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/controller/category_controller.dart';

import 'package:money_app/screen/category/category_popup.dart';
import 'package:money_app/screen/category/expense.dart';
import 'package:money_app/screen/category/income.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final categoryController = Get.put(CategoryController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categoryController.refreshCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 220, 220),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
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
              'Category',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.03),
            child: TabBar(
                indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: const Color.fromARGB(255, 53, 227, 58),
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: 'INCOME',
                  ),
                  Tab(
                    text: 'EXPENCE',
                  ),
                ]),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              IncomeCategoryList(),
              ExpenceCatagoryList(),
            ]),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          FloatingActionButton(
            tooltip: 'Add',
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.green,
            onPressed: () {
              showCategoryAddPopup(context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
