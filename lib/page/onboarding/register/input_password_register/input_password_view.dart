import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../util/global.dart';
import '../../../../widget/button_next.dart';
import '../../login/login_view.dart';
import '../input_full_name_register/input_full_name_view.dart';
import 'input_password_controller.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({Key? key}) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  Widget build(BuildContext context) {
    InputPasswordController inputPasswordController =
        Get.put(InputPasswordController());
    return GetBuilder<InputPasswordController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Đăng ký',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).textTheme.headline6?.color,
                  fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              GestureDetector(
                onTap: (){
                  Get.offAll(() => Login());
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 25),
                  child: Text("Hủy",style: TextStyle(
                    color: Theme.of(context).textTheme.headline6?.color,
                    fontSize: 18,fontWeight: FontWeight.bold
                  )),
                ),
              )
            ],
            elevation: 0,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
            child: Column(
              children: [
                /// title
                const Text('Mật khẩu của bạn',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 10,
                ),

                /// description
                const Text(
                    'Mật khẩu của bạn có ít nhất 6 kí tự và nhiều nhất 12 kí tự',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center),

                /// text field
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: TextField(
                    obscureText: !inputPasswordController.isShowPassword.value,
                    controller: inputPasswordController.passwordController,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorColor: Colors.grey,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Mật khẩu của bạn',
                        hintStyle: const TextStyle(
                          fontFamily: 'NunitoSans',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        counterText: '',
                        suffixIcon: (inputPasswordController
                                .passwordController.text.isEmpty)
                            ? const SizedBox()
                            : inputPasswordController
                                        .passwordController.text.length >=
                                    6
                                ? SizedBox(
                                  width: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          inputPasswordController
                                              .isShowPassword.value =
                                          !inputPasswordController
                                              .isShowPassword.value;
                                          inputPasswordController.update();
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Obx(() => inputPasswordController
                                                .isShowPassword.value ==
                                                true
                                                ? Icon(Icons.visibility,
                                                color: Colors.black)
                                                : Icon(Icons.visibility_off,
                                                color: Colors.black))),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0,12,0,12),
                                          child: Image.asset(IconsAssets.icChecked),
                                        ),
                                    ],
                                  ),
                                )
                                : GestureDetector(
                                    onTap: () {
                                      inputPasswordController
                                              .isShowPassword.value =
                                          !inputPasswordController
                                              .isShowPassword.value;
                                      inputPasswordController.update();
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Obx(() => inputPasswordController
                                                    .isShowPassword.value ==
                                                true
                                            ? Icon(Icons.visibility,
                                                color: Colors.black)
                                            : Icon(Icons.visibility_off,
                                                color: Colors.black))),
                                  )),
                    onChanged: (value) {
                      setState(() {
                        inputPasswordController.password.value = value;
                      });
                    },
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        height: 1.9),
                  ),
                ),

                /// button
                ButtonNext(
                  onTap: () {
                    Global.registerNewPassword =
                        inputPasswordController.password.value;
                    Get.to(() => const InputFullName());
                  },
                  textInside: "Tiếp tục",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
