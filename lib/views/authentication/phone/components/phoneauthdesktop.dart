import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/utils/sized_config.dart';

class PhoenDesktopPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LoginContainerWidget(
          authController: _authController,
        ),
      ),
    );
  }
}

class LoginContainerWidget extends StatelessWidget {
  final AuthController authController;
  LoginContainerWidget({
    Key key,
    this.authController,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      width: SizeConfig.screenWidth * 0.85,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(
          25,
        ),
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.2),
            offset: Offset(0, 3),
            blurRadius: 25,
          ),
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.2),
            offset: Offset(-3, 0),
            blurRadius: 25,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          25,
        ),
        child: Stack(
          children: [
            buildRightWidget(themeData),
            buildLeftWidget(themeData),
          ],
        ),
      ),
    );
  }

  ///[Right] Sided Widget
  Align buildRightWidget(ThemeData themeData) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: (SizeConfig.screenWidth * 0.85) * 0.5,
        color: kPrimaryLightColor.withOpacity(0.5),
        child: buildLoginVector(),
      ),
    );
  }

  ///[LEFT] WIDGET
  Align buildLeftWidget(ThemeData themeData) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: (SizeConfig.screenWidth * 0.85) * 0.5,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 48.0,
            vertical: 48.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle(themeData),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 48.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPhoneRow(),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        buildOTPRow(),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        buildSignUpButton(themeData),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  ///[Email] and [Username] textFields
  Row buildPhoneRow() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            initialValue: authController.phoneNumber.value,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              return email.length == 10
                  ? null
                  : 'Please Enter a valid phonenumber';
            },
            onChanged: (email) {
              authController.phoneNumber.value = email;
            },
            maxLength: 10,
            decoration: InputDecoration(
              prefixText: '+91',
              labelText: 'Phone number',
              hintText: 'Enter your phone number',
            ),
          ),
        ),
      ],
    );
  }

  ///[Password] and [Confirm Password] textFields
  Row buildOTPRow() {
    return Row(
      children: [
        Flexible(
          child: Obx(
            () => TextFormField(
              initialValue: authController.otp.value,
              readOnly: !authController.codeSent.value,
              onChanged: (password) {
                authController.otp.value = password;
              },
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter your Verification Code',
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///[Title]
  Column buildTitle(ThemeData themeData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Phone number',
          style: themeData.textTheme.headline1.copyWith(
            fontSize: 50,
            letterSpacing: 1.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
          child: Text(
            'Login to your account to save a big amount on your next purchase',
            style: themeData.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  ///[Vector]
  SvgPicture buildLoginVector() {
    return SvgPicture.asset(
      'assets/vectors/signup_login.svg',
    );
  }

  ///[Sign Up] buttons
  buildSignUpButton(ThemeData themeData) {
    ConfirmationResult result;
    return Obx(
      () => TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
          minimumSize: MaterialStateProperty.all(
            Size(
              getProportionateScreenWidth(40),
              getProportionateScreenHeight(55),
            ),
          ),
        ),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            if (!authController.codeSent.value) {
              authController.sendOtp();
            } else {
              authController.linkWithCredential();
            }
          }
        },
        child: authController.signingIn.value
            ? CircularProgressIndicator()
            : Obx(
                () => Text(
                  authController.codeSent.value ? 'Verify OTP' : 'Send OTP',
                  style: themeData.textTheme.headline1
                      .copyWith(color: kPrimaryColor.withOpacity(0.8)),
                ),
              ),
      ),
    );
  }
}
