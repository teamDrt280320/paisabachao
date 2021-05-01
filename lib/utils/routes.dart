import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/utils/initialbindings.dart';
import 'package:paisabachao/utils/wrapper.dart';
import 'package:paisabachao/views/authentication/login/login.dart';
import 'package:paisabachao/views/authentication/phone/phoneauth.dart';
import 'package:paisabachao/views/authentication/signup/signup.dart';
import 'package:paisabachao/views/home/home.dart';

class RoutesName {
  static const String SIGNUP = '/signup';
  static const String LOGIN = '/login';
  static const String HOME = '/home';
  static const String WRAPPER = '/';
  static const String PHONEAUTH = '/phone-verification';
}

final List<GetPage> appPages = [
  GetPage(
    name: RoutesName.HOME,
    page: () => HomeScreen(),
    binding: InitialBindings(),
  ),
  GetPage(
    name: RoutesName.LOGIN,
    page: () => LoginPage(),
    binding: InitialBindings(),
  ),
  GetPage(
    name: RoutesName.SIGNUP,
    page: () => SignUpPage(),
    binding: InitialBindings(),
  ),
  GetPage(
    name: RoutesName.WRAPPER,
    page: () => Wrapper(),
    binding: InitialBindings(),
  ),
  GetPage(
    name: RoutesName.PHONEAUTH,
    page: () => PhoneAuthPage(),
    binding: InitialBindings(),
  ),
];
