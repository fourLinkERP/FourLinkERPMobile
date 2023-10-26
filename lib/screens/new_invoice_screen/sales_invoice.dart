import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourlinkmobileapp/constants/colors.dart';
import 'package:fourlinkmobileapp/constants/strings.dart';
import 'package:fourlinkmobileapp/controllers/invoices_controller.dart';
import 'package:fourlinkmobileapp/screens/env/dimensions.dart';
import 'package:fourlinkmobileapp/screens/new_invoice_screen/invoice_english_view.dart';
import 'package:fourlinkmobileapp/screens/shared_widgets/appbar_eng_view.dart';
import 'package:fourlinkmobileapp/screens/shared_widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesInvoiceScreen extends GetView<AllInvoiceController> {
  const SalesInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        appBar: AppBar_eng(
          title: AppStrings.HOME_TITLE,
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed("/new");
              },
              splashColor: AppColors.kSecondaryColor,
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(
                "assets/icons/new_invoice.svg",
                height: Dimensions.calcH(35),
                color: AppColors.kPrimaryDark,
              ),
            ),
            SizedBox(
              width: Dimensions.calcW(15),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.invoicesList.isEmpty) {
            return Center(
              child: CustomText(
                text: AppStrings.HOME_NO_INVOICES,
                color: Colors.black,
                fontSize: Dimensions.calcH(20),
                weight: FontWeight.w600,
              ),
            );
          } else {
            return Column(
              children: [
                ...controller.invoicesList
                    .map((invoice) => InvoiceView_eng(
                  invoice: invoice,
                ))
                    .toList()
              ],
            );
          }
        }));
  }
}