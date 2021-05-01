import 'package:flutter/material.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/utils/sized_config.dart';
import 'package:paisabachao/views/authentication/phone/components/phoneauthdesktop.dart';
import 'package:paisabachao/views/authentication/phone/components/phoneauthmobile.dart';
import 'package:paisabachao/views/authentication/phone/components/phoneauthtablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PhoneAuthPage extends StatelessWidget {
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
        actions: [],
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
            mobile: PhoneMobilePage(),
            desktop: PhoenDesktopPage(),
            tablet: PhoneTabletPage(),
          ),
        ],
      ),
    );
  }
}
