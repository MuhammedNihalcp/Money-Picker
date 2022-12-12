import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_app/model/catagory_data_model.dart';

const categoryDbNames = 'CategoryDb';

class CategoryController extends GetxController {
  RxList<CatagoryModel> incomeCategory = RxList<CatagoryModel>([]);
  RxList<CatagoryModel> expenseCategory = RxList<CatagoryModel>([]);

  addCategory(CatagoryModel model) async {
    final box = await Hive.openBox<CatagoryModel>(categoryDbNames);
    box.put(model.id, model);
    log(box.toString());
    refreshCategory();
    update();
  }

  deleteCategory(String categoryID) async {
    final box = await Hive.openBox<CatagoryModel>(categoryDbNames);
    box.delete(categoryID);
    refreshCategory();
    update();
  }

  Future<List<CatagoryModel>> getAllCategory() async {
    final box = await Hive.openBox<CatagoryModel>(categoryDbNames);
    return box.values.toList();
  }

  resetCategory() async {
    final box = await Hive.openBox<CatagoryModel>(categoryDbNames);
    box.clear();
    update();
  }

  refreshCategory() async {
    final allCategory = await getAllCategory();
    incomeCategory.clear();
    expenseCategory.clear();
    await Future.forEach(allCategory, (CatagoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategory.add(category);
        log(incomeCategory.toString());
      } else {
        expenseCategory.add(category);
      }
    });
  }
}
