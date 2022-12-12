import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/model/catagory_data_model.dart';

const categoryDbName = 'category_db';

abstract class CategoryDbFunction {
  Future<List<CatagoryModel>> getCategory();
  Future<void> insertCategory(CatagoryModel value);
  Future<void> deleteCategory(String categoryID);
  Future<void> updateCategory(int id, CatagoryModel value);
  Future<void> restratCategory();
}

class CategoryDB implements CategoryDbFunction {
  late DateTime startDate;
  late DateTime endDate;

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  bool isFilterEnabled = false;
  ValueNotifier<List<CatagoryModel>> incomeCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<CatagoryModel>> expenseCategoryNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CatagoryModel value) async {
    final categoryDB = await Hive.openBox<CatagoryModel>(categoryDbName);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CatagoryModel>> getCategory() async {
    final categoryDB = await Hive.openBox<CatagoryModel>(categoryDbName);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategory = await getCategory();
    incomeCategoryNotifier.value.clear();
    expenseCategoryNotifier.value.clear();
    await Future.forEach(allCategory, (CatagoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryNotifier.value.add(category);
      } else {
        expenseCategoryNotifier.value.add(category);
      }
    });

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategoryNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenseCategoryNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CatagoryModel>(categoryDbName);
    categoryDB.delete(categoryID);
    refreshUI();
  }

  @override
  Future<void> updateCategory(int id, CatagoryModel value) async {
    final categoryDB = await Hive.openBox<CatagoryModel>(categoryDbName);
    categoryDB.putAt(id, value);
    refreshUI();
  }

  @override
  Future<void> restratCategory() async {
    final categoryDB = await Hive.openBox<CatagoryModel>(categoryDbName);
    categoryDB.clear();
  }

  setFilter(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    isFilterEnabled = true;
    refreshUI();
  }

  clearFilter() {
    isFilterEnabled = false;
    refreshUI();
  }
}
