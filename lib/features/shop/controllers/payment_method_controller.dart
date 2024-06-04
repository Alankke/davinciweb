import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PaymentMethodController extends GetxController {
  //Lógicas
  var selectedPaymentMethod = Rx<String?>(null);

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }
}