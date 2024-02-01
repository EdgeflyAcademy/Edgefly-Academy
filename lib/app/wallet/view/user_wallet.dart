import 'package:get/get.dart';

class UserWalletController extends GetxController {
  var balance = 0.0.obs;

  void updateBalance(double newBalance) {
    balance.value = newBalance;
  }
}
