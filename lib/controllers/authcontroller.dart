import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paisabachao/utils/wrapper.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  Rx<User> user = Rx<User>(null);
  User setUser(User user1) => user.value = user1;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final email = ''.obs;
  final password = ''.obs;
  final uname = ''.obs;
  final signingIn = false.obs;
  final phoneNumber = ''.obs;
  final otp = ''.obs;
  final verificationId = ''.obs;
  final resendToken = 0.obs;
  final codeSent = false.obs;

  ///[on Init]
  @override
  void onInit() {
    user.bindStream(auth.userChanges());
    setUser(auth.currentUser);
    googleSignIn.signInSilently();
    super.onInit();
  }

  ///[Phone Verification]
  sendOtp() async {
    signingIn.value = true;
    try {
      if (kIsWeb) {
        var result = await auth.signInWithPhoneNumber(
          "+91" + phoneNumber.value,
        );
        codeSent.value = true;
        verificationId.value = result.verificationId;
      } else {
        await auth.verifyPhoneNumber(
            phoneNumber: "+91" + phoneNumber.value,
            verificationCompleted: (credential) async {
              var creds = await auth.currentUser.linkWithCredential(credential);
              setUser(creds.user);
            },
            verificationFailed: (e) {
              Get.snackbar(
                'Error Occured',
                e.message,
              );
            },
            codeSent: (verificationId, resendToken) {
              codeSent.value = true;
              this.verificationId.value = verificationId;
              this.resendToken.value = resendToken;
            },
            codeAutoRetrievalTimeout: (verificationId) {
              this.verificationId.value = verificationId;
            });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      signingIn.value = false;
    }
  }

  ///[Verify] phone number
  linkWithCredential() async {
    signingIn.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp.value,
      );
      var creds = await auth.currentUser.linkWithCredential(credential);
      setUser(creds.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {
        Get.snackbar(
          'Error Occurred',
          'Account allready contains a phone number',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Error Occurred',
          'Provided credential is not vallid',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'credential-already-in-use') {
        Get.snackbar(
          'Error Occurred',
          'Provided phone number is already in use',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'invalid-verification-code') {
        Get.snackbar(
          'Error Occurred',
          'Provided Verification Code is not valid',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'invalid-verification-code') {
        Get.snackbar(
          'Error Occurred',
          'Provided Verification Code is not valid',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      // if (user.value != null) {
      //   if (user.value.phoneNumber != null)
      //     Get.offNamed(RoutesName.HOME);
      //   else
      //     Get.offNamed(RoutesName.PHONEAUTH);
      // }
      signingIn.value = false;
    }
  }

  ///[Sign In] with [Google]
  signInWithGoogle() async {
    if (signingIn.value) return;
    signingIn.value = true;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      ///
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      ///[AuthCredential]
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      ///
      try {
        var userCredential = await auth.signInWithCredential(credential);
        setUser(userCredential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar(
            'Error Occurred',
            'Account already exists but With different credentials',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else if (e.code == 'invalid-credential') {
          Get.snackbar(
            'Error Occurred',
            'Please Verify your email and password',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error Occurred',
          'We are looking into it',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        if (user.value != null) {
          Get.off(() => Wrapper());
        }
        // if (user.value != null) {
        //   if (user.value.phoneNumber != null)
        //     Get.offNamed(RoutesName.WRAPPER);
        //   else
        //     Get.offNamed(RoutesName.PHONEAUTH);
        // }
        signingIn.value = false;
      }
    }
  }

  ///[Sign In] with [Email] and [Password]
  signInWithEmailAndPassword() async {
    if (signingIn.value) return;
    try {
      signingIn.value = true;
      var userCredential = await auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      setUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error Occurred',
          'Provided email is invalid',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'user-disabled') {
        Get.snackbar(
          'Error Occurred',
          'Account is disabled',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error Occurred',
          'User not found',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error Occurred',
          'Provided password is wrong',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Occurred',
        'Please Verify your email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (user.value != null) {
        Get.off(() => Wrapper());
      }
      // if (user.value != null) {
      //   if (user.value.phoneNumber != null)
      //     Get.offNamed(RoutesName.WRAPPER);
      //   else
      //     Get.offNamed(RoutesName.PHONEAUTH);
      // }
      signingIn.value = false;
    }
  }

  ///[Create] user by [Email] and [Password]
  createUserWithEmailAndPassword() async {
    if (signingIn.value) return;

    try {
      signingIn.value = true;
      var userCredential = await auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      setUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error Occurred',
          'Provided email is already in use',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error Occurred',
          'Provided email is invalid',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          'Error Occurred',
          'Provided password is too weak',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Occurred',
        'We are looking into it!!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (user.value != null) {
        Get.off(() => Wrapper());
      }
      signingIn.value = false;
    }
  }

  ///[Sign Out]
  signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
