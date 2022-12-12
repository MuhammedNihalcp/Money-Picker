import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/controller/filltretion_controller.dart';
import 'package:money_app/controller/transaction_controller.dart';

import 'package:money_app/model/transaction_data_model.dart';

final TrasactionDelete tD = TrasactionDelete();

class TrasactionDelete {
  final transactionController = Get.put(TransactionController());
  final filtertionController = Get.put(FiltretionController());

  Future<void> showTransactionDelete(
      BuildContext context, TransactionModel model) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete',
            textAlign: TextAlign.center,
          ),
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Selected transaction will be deleted permanetly',
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.w500),
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
                    transactionController.deleteTransaction(model.id!);
                    filtertionController.filterControllerFunction();
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
