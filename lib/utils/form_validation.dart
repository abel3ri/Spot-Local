import 'package:get/get.dart';
import 'package:get/utils.dart';

class FormValidator {
  static String? nameValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterName".tr;
    if (!RegExp(r"[a-zA-Z]+").hasMatch(value)) return "pleaseEnterValidName".tr;
    return null;
  }

  static String? urlValidator(String? value) {
    if (value!.isEmpty) return null;

    if (!GetUtils.isURL(value)) {
      return "Please enter a valid URL";
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterUsername".tr;
    if (value.length < 5) return "pleaseEnterValidUsernameLen".tr;
    if (!GetUtils.isUsername(value)) return "pleaseEnterValidUsername".tr;
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) return "Please enter a phone number".tr;
    if (value.length < 5) return "pleaseEnterValidUsernameLen".tr;
    if (GetUtils.isUsername(value)) return "pleaseEnterValidUsername".tr;
    return null;
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterEmail".tr;
    if (!GetUtils.isEmail(value)) return "pleaseEnterValidEmail".tr;
    return null;
  }

  static String? passwordValidtor(String? value) {
    if (value!.isEmpty) return "pleaseEnterPassword".tr;
    if (value.length < 8) return "pleaseEnterValidPassword".tr;
    return null;
  }

  static String? licenseNumberValidator(String? value) {
    if (value!.isEmpty) return "Please enter license number".tr;
    if (value.length != 10) return "Please enter a valid license number".tr;
    return null;
  }

  static String? textValidtor(String? value) {
    if (value!.isEmpty) return "Please fill out this field".tr;
    return null;
  }

  static String? otpValidator(String? value) {
    if (value!.isEmpty) return "Please provide OTP";
    if (value.length != 6) return "OTP must be 6 characters long";
    return null;
  }

  static confirmPasswordValidator({String? password, String? rePassword}) {
    if (rePassword == null || rePassword.isEmpty) {
      return 'Please re-enter your password';
    }
    if (rePassword.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (rePassword != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? reviewValidator(String? value) {
    if (value!.isEmpty) return "Please provide a review";
    return null;
  }
}
