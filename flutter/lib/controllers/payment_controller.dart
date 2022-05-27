import 'package:get/state_manager.dart';
import 'package:at_coffee/models/payment.dart';
import 'package:at_coffee/services/service_payment.dart';

class PaymentController extends GetxController {
  var isLoading = true.obs;
  var paymentsList = new List<Payment>().obs;

  @override
  void onInit() {
    fetchPayments();
    super.onInit();
  }

  void fetchPayments() async {
    try {
      isLoading.value = true;
      var payments = await RemoteServices.fetchPayments();
      if (payments != null) {
        paymentsList.value = payments;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
