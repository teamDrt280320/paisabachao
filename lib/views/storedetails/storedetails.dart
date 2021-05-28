import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisabachao/controllers/couponcontroller.dart';
import 'package:paisabachao/utils/constants.dart';
import 'package:paisabachao/utils/sized_config.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StoreDetails extends StatefulWidget {
  final String link;

  const StoreDetails({Key key, this.link}) : super(key: key);
  @override
  _StoreDetailsState createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  CouponController _couponController = Get.find();
  @override
  void initState() {
    _couponController.fetchCoupon(widget.link);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colo,
          ),
      backgroundColor: kPrimaryLightColor,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.025,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: (SizeConfig.screenHeight * 0.1) / 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.1),
                        offset: Offset(1, 1),
                        blurRadius: 5.0,
                      ),
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.1),
                        offset: Offset(-1, -1),
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Space For Advertisement',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  )),
            ),
            Flexible(
              flex: 3,
              child: Obx(() => _couponController.storeDetails.value != null
                  ? _couponController.storeDetails.value.coupon.length > 0
                      ? ListView.builder(
                          itemCount: _couponController
                              .storeDetails.value.coupon.length,
                          itemBuilder: (context, index) {
                            var storeDetails = _couponController
                                .storeDetails.value.coupon[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      (SizeConfig.screenHeight * 0.1) / 10),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 48.0,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.1),
                                        offset: Offset(1, 1),
                                        blurRadius: 5.0,
                                      ),
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.1),
                                        offset: Offset(-1, -1),
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                width: double.infinity,
                                height: SizeConfig.screenHeight * 0.20,
                                child: ClipRect(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.amberAccent
                                                    .withOpacity(0.2),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            label: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                'Top Deals',
                                                style: GoogleFonts.openSans(
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: kSecondaryColor
                                                        .withOpacity(0.2),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 16,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  storeDetails.dicount
                                                      .toString()
                                                      .replaceAll(' ', '\n'),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(5),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AutoSizeText(
                                                _couponController
                                                    .storeDetails.value.name
                                                    .toString()
                                                    .replaceAll(
                                                      'Coupons',
                                                      '',
                                                    ),
                                                style: GoogleFonts.openSans(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AutoSizeText(
                                                storeDetails.description
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenWidth(
                                                  5,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextButton(
                                                    style: ButtonStyle(
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      side:
                                                          MaterialStateProperty
                                                              .all(
                                                        BorderSide(
                                                          color: kPrimaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14.0),
                                                      child: Text(
                                                        'Get Code',
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Sorry No Coupons Available\nCheck Back Later',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
