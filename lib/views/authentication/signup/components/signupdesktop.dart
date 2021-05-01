import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/utils/sized_config.dart';
import 'package:paisabachao/utils/extensions.dart';
import 'package:paisabachao/views/authentication/login/login.dart';

class SignUpDesktop extends StatefulWidget {
  @override
  _SignUpDesktopState createState() => _SignUpDesktopState();
}

class _SignUpDesktopState extends State<SignUpDesktop> {
  AuthController _authController = Get.find();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLoginOption(themeData),
            buildLoginVector(),
          ],
        ),
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
                        buildNameEmailRow(),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        buildPasswordRow(),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        buildSignUpButton(themeData),
                        SizedBox(
                          height: getProportionateScreenHeight(50),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                authController.signInWithGoogle();
                              },
                              backgroundColor: kPrimaryColor,
                              child: Icon(MdiIcons.google),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              child: Icon(
                                MdiIcons.facebook,
                                color: kPrimaryColor,
                                size: 48,
                              ),
                            ),
                          ],
                        ),
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
  Row buildNameEmailRow() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (name) {
              return name.isValidUserName()
                  ? null
                  : 'Please Enter a valid username';
            },
            onChanged: (name) {
              authController.uname.value = name;
            },
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(5.0),
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              return email.isEmail ? null : 'Please Enter a valid username';
            },
            onChanged: (email) {
              authController.email.value = email;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
          ),
        ),
      ],
    );
  }

  ///[Password] and [Confirm Password] textFields
  Row buildPasswordRow() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            obscureText: true,
            validator: (password) {
              return password.isPasswordValid();
            },
            onChanged: (password) {
              authController.password.value = password;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(5.0),
        ),
        Flexible(
          child: TextFormField(
            validator: (confirmpassword) {
              return authController.password.value == confirmpassword
                  ? confirmpassword.isNotEmpty
                      ? null
                      : 'Please Enter a password'
                  : 'Passwords don\'t match';
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm password',
              hintText: 'Confirm your password',
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
          'Create Account',
          style: themeData.textTheme.headline1.copyWith(
            fontSize: 50,
            letterSpacing: 1.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
          child: Text(
            'Create an account to save a big amount on your next purchase',
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

  ///[Login] option
  Row buildLoginOption(ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Already have an account?',
          style: themeData.textTheme.headline1,
        ),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: kPrimaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              Size(
                getProportionateScreenWidth(40),
                getProportionateScreenHeight(50),
              ),
            ),
          ),
          onPressed: () {
            Get.to(() => LoginPage());
          },
          child: Text(
            'Login',
            style: themeData.textTheme.headline1.copyWith(
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }

  ///[Sign Up] buttons
  buildSignUpButton(ThemeData themeData) {
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
        onPressed: () {
          if (formKey.currentState.validate()) {
            authController.createUserWithEmailAndPassword();
          }
        },
        child: authController.signingIn.value
            ? CircularProgressIndicator()
            : Text(
                'Sign Up',
                style: themeData.textTheme.headline1
                    .copyWith(color: kPrimaryColor.withOpacity(0.8)),
              ),
      ),
    );
  }
}
