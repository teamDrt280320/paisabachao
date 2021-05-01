import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/utils/routes.dart';
import 'package:paisabachao/utils/sized_config.dart';
import 'package:paisabachao/views/authentication/phone/phoneauth.dart';
import 'package:paisabachao/views/authentication/signup/signup.dart';
import 'package:paisabachao/views/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AuthController _authController = Get.find();

    return Obx(() => _authController.user.value == null
        ? SignUpPage()
        : _authController.user.value.phoneNumber == null
            ? PhoneAuthPage()
            : HomeScreen());
  }
}
