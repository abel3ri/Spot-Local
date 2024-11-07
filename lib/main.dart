import 'package:business_dir/app/bindings/app_bindings.dart';
import 'package:business_dir/app/controllers/locale_controller.dart';
import 'package:business_dir/app/controllers/theme_controller.dart';
import 'package:business_dir/app/l10n/app_translations.dart';
import 'package:business_dir/services/theme_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());
  final localeController = Get.put(LocaleController());
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
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
        locale: localeController.currentLocale.value,
        fallbackLocale: const Locale("en", "us"),
        defaultTransition: Transition.cupertino,
      ),
    ),
  );
}
