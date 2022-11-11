import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/db_function/catagory_db.dart';
import 'package:money_app/model/catagory_data_model.dart';
import 'package:money_app/screen/category/category_delete_popup.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryNotifier,
      builder: (BuildContext ctx, List<CatagoryModel> incomeCategoryList,
          Widget? _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomCard(
              width: width,
              height: height * 0.6,
              borderRadius: 20,
              elevation: 0,
              color: const Color.fromARGB(222, 206, 205, 205),
              child: incomeCategoryList.isEmpty
                  ? Stack(
                      children: [
                        Center(
                          child: Text(
                            'No Income Categories Available',
                            style: GoogleFonts.anton(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 27, 88, 83),
                            ),
                          ),
                        ),
                        Center(
                          child: Lottie.asset(
                            'lib/assets/image/lotties/lf20_jyguxb6d.json',
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 50,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (ctx, index) {
                        final categoryData = incomeCategoryList[index];
                        return ListTile(
                          leading: Text(
                            categoryData.name,
                            style: const TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showCategoryDelete(context, categoryData);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 19,
                                color: Colors.black,
                              )),
                        );
                      },
                      itemCount: incomeCategoryList.length),
            ),
          ),
        );
      },
    );
  }
}
