import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/db_function/filteration_db.dart';
import 'package:money_app/db_function/transaction_db.dart';
import 'package:money_app/db_function/user_name_db.dart';
import 'package:money_app/main.dart';
import 'package:money_app/model/user_name_data_model.dart';
import 'package:money_app/screen/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  RegExp regx =
      RegExp(r'''[₹+×÷=/_€£¥₩;'`~\°•○●□■♤♡◇♧☆▪︎¤《》"¡¿!@#$%^&*(),.?:{}|<>]''');

  @override
  void initState() {
    filterFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/image/welcome Screen.png'),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.15,
                  ),
                  const Text(
                    'Welcome Onboard !',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.033,
                  ),
                  const Text(
                    'Lets help you meet up your tasks',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Image.asset(
                    'lib/assets/image/undraw_Welcome_re_h3d9.png',
                    width: width * 0.4,
                    height: height * 0.3,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Full name should not be empty';
                        } else if(value.startsWith(regx)){
                          return 'User name should not start with any special characters';  
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Full name',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(195, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(195, 255, 255, 255),
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.085,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(width * 0.92, height * 0.08),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkToRegistor(context);
                      } else {}
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> checkToRegistor(BuildContext context) async {
    final fullname = _fullNameController.text.trim();
    if (fullname.isNotEmpty) {
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool(saveKeyValue, true);

      if (!mounted) {
        return;
      }
      final userModel = UserNameModel(
        username: fullname,
      );
      UserNameDB.instance.addName(userModel);
      UserNameDB.instance.getUserName();
      TransactionDB.instance.transactionhomeListNotifier;
      filterFunction();
      Get.off(() => const ScreenNavigator());
    } else {}
  }
}
