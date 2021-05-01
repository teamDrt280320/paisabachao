import 'package:get/instance_manager.dart';
import 'package:paisabachao/controllers/authcontroller.dart';
import 'package:paisabachao/controllers/couponcontroller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(CouponController(), permanent: true);
  }
}
