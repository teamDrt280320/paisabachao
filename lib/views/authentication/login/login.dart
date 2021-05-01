import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/utils/routes.dart';
import 'package:paisabachao/utils/sized_config.dart';
import 'package:paisabachao/views/authentication/login/components/logindesktop.dart';
import 'package:paisabachao/views/authentication/login/components/loginmobile.dart';
import 'package:paisabachao/views/authentication/login/components/logintablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        shadowColor: kPrimaryColor.withOpacity(0.4),
        centerTitle: false,
        // backgroundColor: kPrimaryLightColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Paisa Bachao.co',
          style: Theme.of(context).textTheme.headline1.copyWith(
                color: Color(0xFF1464FF).withOpacity(0.5),
              ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            child: TextButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    getProportionateScreenWidth(30.0),
                    getProportionateScreenWidth(20),
                  ),
                ),
              ),
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(RoutesName.HOME);
              },
              label: Text(
                'Skip',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: SizeConfig.screenWidth * 0.5,
              color: kPrimaryLightColor,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: SizeConfig.screenWidth * 0.5,
              color: Color(0xFF1464FF).withOpacity(0.5),
            ),
          ),
          ScreenTypeLayout(
            mobile: LoginMobilePage(),
            desktop: LoginDesktopPage(),
            tablet: LoginTablePage(),
          ),
        ],
      ),
    );
  }
}
