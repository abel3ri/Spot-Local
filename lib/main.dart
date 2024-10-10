import 'package:business_dir/app/bindings/app_bindings.dart';
import 'package:business_dir/app/controllers/theme_controller.dart';
import 'package:business_dir/app/l10n/app_translations.dart';
import 'package:business_dir/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());

  runApp(
    GetMaterialApp(
      initialBinding: AppBindings(),
      title: "Business Directory",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.currentTheme.value,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Locale("am", "et"),
      fallbackLocale: Locale("en", "us"),
      defaultTransition: Transition.cupertino,
    ),
  );
}
