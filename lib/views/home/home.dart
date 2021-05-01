import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:paisabachao/controllers/couponcontroller.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/views/authentication/login/login.dart';
import 'package:paisabachao/views/authentication/signup/signup.dart';
import 'package:paisabachao/views/storedetails/storedetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CouponController _couponController = Get.find();
  @override
  void initState() {
    _couponController.fetchtopCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: buildHeader(),
              ),
            ),
            buildCustSpacer(context),
            buildWelcome(context),
            buildCustSpacer(context),
            buildSearchWidget(context),
            buildCustSpacer(context),
            buildtopBrandsList(context),
          ],
        ),
      ),
    );
  }

  SizedBox buildCustSpacer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
    );
  }

  SizedBox buildWelcome(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Center(
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "We have a deal for you!",
                style: GoogleFonts.openSans(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "With 4000+ offers from 2000+ stores, \nwe have coupons from a to z you have option to choose from a wide range.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "OpenSans",
                    wordSpacing: 2,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSearchWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: secondary.withOpacity(0.1),
            offset: Offset(1.0, 1.0),
            blurRadius: 15.0,
            spreadRadius: 2.0,
          )
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 32,
            color: primary1,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: TextFormField(
                style: TextStyle(
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'E.g. Amazon,Flipkart',
                  hintStyle: GoogleFonts.openSans(
                    color: kPrimaryColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Search",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: secondary,
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.08,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildtopBrandsList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Obx(
        () => GridView.extent(
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          maxCrossAxisExtent: 200.0,
          children: List.generate(
            _couponController.topCoupons.length,
            (index) {
              var topCoupon = _couponController.topCoupons[index];
              return InkWell(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(
                    () => StoreDetails(
                      link: topCoupon.storeurl,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HoverAnimatedContainer(
                    hoverDecoration: BoxDecoration(
                      border: Border.all(
                        color: secondary.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    cursor: SystemMouseCursors.basic,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kSecondaryColor.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: kSecondaryColor.withOpacity(0.1),
                          offset: Offset(-3, -3),
                          blurRadius: 16.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.network(
                        topCoupon.logosrc,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Row buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "PaisaBachao.co",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: primary1,
          ),
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Browse",
                  style:
                      TextStyle(color: primary1, fontWeight: FontWeight.w700),
                )),
            SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => LoginPage());
                },
                child: Text(
                  "Log In",
                  style:
                      TextStyle(color: primary1, fontWeight: FontWeight.w700),
                )),
            SizedBox(
              width: 20,
            ),
            TextButton(
              child: Text(
                "Sign In",
                style: TextStyle(color: secondary, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Get.to(() => SignUpPage());
              },
            )
          ],
        )
      ],
    );
  }
}
