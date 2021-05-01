import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:paisabachao/modals/storedetails.dart';
import 'package:paisabachao/modals/topcoupon.dart';

class CouponController extends GetxController {
  static var firestore = FirebaseFirestore.instance;
  var couponCollection = firestore.collection('coupons');
  var topCouponCollection = firestore.collection('topproducts');
  RxList<TopCoupon> topCoupons = <TopCoupon>[].obs;
  Rx<StoreDetailsModal> storeDetails = Rx<StoreDetailsModal>(null);

  fetchCoupon(String link) {
    couponCollection.where('link', isEqualTo: link).snapshots().listen(
      (snapshot) {
        for (var item in snapshot.docs) {
          storeDetails.value = new StoreDetailsModal.fromJson(
            item.data(),
          );
        }
      },
    );
  }

  fetchtopCoupons() async {
    await topCouponCollection.get().then((snapshot) {
      topCoupons.clear();
      for (var coupon in snapshot.docs) {
        topCoupons.add(
          new TopCoupon.fromJson(
            coupon.data(),
          ),
        );
      }
    });
  }
}
