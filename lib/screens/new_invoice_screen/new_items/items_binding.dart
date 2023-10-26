import '../../../../controllers/invoiceItems_controller.dart';
import 'package:get/get.dart';

class ItemsBidning extends Bindings {
  @override
  void dependencies() {
    Get.put(InvoiceItemsController(), permanent: true);
  }
}
