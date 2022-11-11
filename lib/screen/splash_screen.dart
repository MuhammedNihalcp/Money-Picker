import 'package:flutter/material.dart';
import 'package:money_app/db_function/filteration_db.dart';
import 'package:money_app/db_function/transaction_db.dart';
import 'package:money_app/db_function/user_name_db.dart';
import 'package:money_app/main.dart';
import 'package:money_app/screen/navigator.dart';
import 'package:money_app/screen/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkRegister(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TransactionDB.instance.refreshHome();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.45,
            ),
            const Image(
              image: AssetImage('lib/assets/image/App_Icon.png'),
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: height * 0.4,
            ),
            const Text('version 1.0.0')
          ],
        ),
      ),
    );
  }

  Future<void> goToGetPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const GetScreen()));
  }

  Future<void> checkRegister(BuildContext context) async {
    final sharePrefs = await SharedPreferences.getInstance();
    final userRegistered = sharePrefs.getBool(saveKeyValue);
    if (userRegistered == null || userRegistered == false) {
      goToGetPage();
    } else {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) {
        return;
      }
      UserNameDB.instance.getUserName();
      filterFunction();
      
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ScreenNavigator()));
    }
  }
}
