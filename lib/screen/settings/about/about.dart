import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_app/db_function/user_name_db.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 220, 220),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 220, 220),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'A b o u t',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                  ),
                  controller: tabController,
                  labelStyle: const TextStyle(fontSize: 18),
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey[400],
                  tabs: const [
                    Tab(
                      text: 'App',
                    ),
                    Tab(
                      text: 'Developer',
                    ),
                    Tab(
                      text: 'Read Me',
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0163,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.blue,
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.greenAccent, Colors.lightGreen],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      height: height * 0.526,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView(
                              children: [
                                Text(
                                  'Hi ${UserNameDB.instance.userNameNotifier.value.username},\n\nwelcome to Money Picker. Money Picker will help you take your budget, money and finance under control and won\'t take much time. you won\'t need to dig through your wallet or check your bank account to be aware of your financial circumstances. Money Picker is very easy to use: you can quickly add a transaction with just a couple of clicks.We are trying to improve our app, If you have any suggestions, you can inform me by clicking the feed back section in settings, We will try to make money picker more better, Thank you.',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    // letterSpacing: 0.5,
                                    wordSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Center(
                              child: Text(
                                'I am Muhammed Nihal. Expertised in UI/UX Designing and Flutter development based on Kerala, If you have any queries related to money Picker or about me you can contact me by taping \'Contact Me\' on the settings.Once of all thank you for supporting me.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Center(
                              child: ListView(
                                children: const [
                                  Text(
                                    'There are some features that you may not know.\n\n\n\n1. Tap on See all category to navigate to Category page.\n\n2. Click on your name in HomePage to edit your name.\n\n3. Tap on the Plus button to add transactions.\n\n4. Slide to left or right to edit and delete (on Second Page).\n\n5. Click the Restart App button to restart the app (on Fourth Page)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                const Text(
                  'version 1.0.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
