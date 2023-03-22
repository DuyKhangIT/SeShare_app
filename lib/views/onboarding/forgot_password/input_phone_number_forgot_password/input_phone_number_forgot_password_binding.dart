import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'input_phone_number_forgot_password_controller.dart';

class InputPhoneNumberForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputPhoneNumberForgotPasswordController());
  }
}