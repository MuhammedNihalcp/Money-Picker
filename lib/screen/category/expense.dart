import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/controller/category_controller.dart';
import 'package:money_app/screen/category/category_delete_popup.dart';

final CategoryDelete cD = CategoryDelete();

class ExpenceCatagoryList extends StatelessWidget {
  ExpenceCatagoryList({super.key});
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: CustomCard(
                  width: width,
                  height: height * 0.6,
                  borderRadius: 20,
                  elevation: 0,
                  color: const Color.fromARGB(222, 206, 205, 205),
                  child: categoryController.expenseCategory.isEmpty
                      ? Stack(
                          children: [
                            Center(
                              child: Text(
                                'No Expense Categories Available',
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
                            final categoryData =
                                categoryController.expenseCategory[index];
                            return ListTile(
                              leading: Text(
                                categoryData.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  cD.showCategoryDelete(context, categoryData);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 19,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                          itemCount: categoryController.expenseCategory.length),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
