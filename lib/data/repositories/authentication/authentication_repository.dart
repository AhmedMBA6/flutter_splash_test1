import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_splash_test1/features/authentication/screens/login/login_screen.dart';
import 'package:flutter_splash_test1/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_splash_test1/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:flutter_splash_test1/navigation_menu.dart';
import 'package:flutter_splash_test1/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:flutter_splash_test1/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_splash_test1/utils/exceptions/format_exceptions.dart';
import 'package:flutter_splash_test1/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // Check if it's the first time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() =>
              const LoginScreen()) // Redirect to Login Screen if not the first time
          : Get.offAll(() =>
              const OnBoardingScreen()); // Redirect to onboarding if it's the first time
    }
  }

  /* ----------------------------------------Email & Password Sign-in -------------------------------------*/

  /// [Email Authentication] - sign-in

  /// [Email Authentication] - rigister
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatExceptions();
    } on PlatformException catch (e) {
      throw MPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong, Please try again';
    }
  }

  /// [ ReAuthentication] - Reauthenticate User

  /// [Email verification] - MAIL Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatExceptions();
    } on PlatformException catch (e) {
      throw MPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong, please try again.';
    }
  }

  /// [Email Authentication] - Forgot Password

  /* ----------------------------------------Federated identity & social sign-in -------------------------------------*/

  /// [Google Authentication] - Google

  /// [Facebook Authentication] - Facebook

  /* ----------------------------------------end Federated identity & social sign-in -------------------------------------*/

  /// [Logout User]
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatExceptions();
    } on PlatformException catch (e) {
      throw MPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong, please try again.';
    }
  }

  /// Delete User - Remove user auth and firestore account
}
