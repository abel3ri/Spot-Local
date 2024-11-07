import 'package:get/get.dart';
import 'package:get/utils.dart';

class FormValidator {
  static String? nameValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterName".tr;
    if (!RegExp(r"[a-zA-Z]+").hasMatch(value)) return "pleaseEnterValidName".tr;
    return null;
  }

  static String? urlValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!GetUtils.isURL(value)) {
      return "pleaseEnterValidUrl".tr;
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
    if (value!.isEmpty) return "pleaseEnterPhone".tr;
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
    if (value!.isEmpty) return "pleaseEnterLicenseNumber".tr;
    return null;
  }

  static String? textValidtor(String? value) {
    if (value!.isEmpty) return "pleaseFillOutThisField".tr;
    return null;
  }

  static String? otpValidator(String? value) {
    if (value!.isEmpty) return "pleaseProvideOTP".tr;
    if (value.length != 6) return "otpMustBeSixChars".tr;
    return null;
  }

  static confirmPasswordValidator({String? password, String? rePassword}) {
    if (rePassword == null || rePassword.isEmpty) {
      return 'pleaseReenterPass'.tr;
    }
    if (rePassword.length < 8) {
      return "passMustBeSixChars".tr;
    }
    if (rePassword != password) {
      return "passDoNotMatch".tr;
    }
    return null;
  }

  static String? reviewValidator(String? value) {
    if (value!.isEmpty) return "pleaseProvideReview".tr;
    return null;
  }

  static String? cityValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterCityName".tr;
    return null;
  }

  static String? categoryNameValidator(String? value) {
    if (value!.isEmpty) return "pleaseProvideCatgeoryName".tr;
    return null;
  }

  static String? categoryIconValidtor(String? value) {
    if (value!.isEmpty) return "pleaseProvideCategoryIcon".tr;
    if (!value.contains("svg")) return "pleaseEnterValidSVG".tr;
    return null;
  }

  static String? categoryDescriptionValidator(String? value) {
    if (value!.isEmpty) return "pleaseEnterCatgeoryDesc".tr;
    return null;
  }
}
