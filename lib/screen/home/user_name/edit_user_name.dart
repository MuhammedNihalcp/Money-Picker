import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/db_function/user_name_db.dart';
import 'package:money_app/screen/navigator.dart';

class EditUserName {
  final formkey = GlobalKey<FormState>();
  RegExp regx =
      RegExp(r'''[₹+×÷=/_€£¥₩;'`~\°•○●□■♤♡◇♧☆▪︎¤《》"¡¿!@#$%^&*(),.?:{}|<>]''');

  editUserName(
    context,
    String text,
  ) {
    final usernamecontroller = TextEditingController();
    usernamecontroller.text =
        UserNameDB.instance.userNameNotifier.value.username;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: formkey,
            child: TextFormField(
              autofocus: true,
              maxLength: 15,
              controller: usernamecontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'User name should not be empty';
                } else if (value.startsWith(regx)) {
                  return 'User name should not start with any special characters';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 200,
              ),
              child: IconButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    UserNameDB.instance.userNameNotifier.value
                        .updateusername(usernamecontroller.text.trim());

                    Get.offAll(() => const ScreenNavigator());
                    UserNameDB.instance.getUserName();
                    Get.snackbar(
                      '',
                      'username updated succefully  ✓',
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.green,
                      margin: const EdgeInsets.all(10),
                    );
                  }
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
