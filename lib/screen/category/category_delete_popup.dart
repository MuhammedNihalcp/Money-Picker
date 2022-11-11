import 'package:flutter/material.dart';
import 'package:money_app/db_function/catagory_db.dart';
import 'package:money_app/model/catagory_data_model.dart';

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
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  CategoryDB.instance.deleteCategory(model.id);
                  Navigator.of(context).pop();
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
