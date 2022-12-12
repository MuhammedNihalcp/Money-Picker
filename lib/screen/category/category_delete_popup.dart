import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/controller/category_controller.dart';

import 'package:money_app/model/catagory_data_model.dart';

class CategoryDelete {
  final categoryController = Get.put(CategoryController());

  Future<void> showCategoryDelete(
      BuildContext context, CatagoryModel model) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Delete',
            textAlign: TextAlign.center,
          ),
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Selected Category will be deleted permanetly',
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    categoryController.deleteCategory(model.id);
                    Get.back();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
