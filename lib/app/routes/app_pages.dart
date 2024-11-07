import 'package:business_dir/app/modules/admin_panel/views/admin_panel_view.dart';
import 'package:get/get.dart';

import '../modules/business_details/bindings/business_details_binding.dart';
import '../modules/business_details/views/business_details_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/change_language/views/change_language_view.dart';
import '../modules/create_business/bindings/create_business_binding.dart';
import '../modules/create_business/views/create_business_view.dart';
import '../modules/edit_business/bindings/edit_business_binding.dart';
import '../modules/edit_business/views/edit_business_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/feature_business/bindings/feature_business_binding.dart';
import '../modules/feature_business/views/feature_business_view.dart';
import '../modules/feature_history/bindings/feature_history_binding.dart';
import '../modules/feature_history/views/feature_history_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/help_and_support/views/help_and_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_wrapper/bindings/home_wrapper_binding.dart';
import '../modules/home_wrapper/views/home_wrapper_view.dart';
import '../modules/image_picker/bindings/image_picker_binding.dart';
import '../modules/image_picker/views/image_picker_view.dart';
import '../modules/image_preview/bindings/image_preview_binding.dart';
import '../modules/image_preview/views/image_preview_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage_businesses/bindings/manage_businesses_binding.dart';
import '../modules/manage_businesses/views/manage_businesses_view.dart';
import '../modules/manage_categories/bindings/manage_categories_binding.dart';
import '../modules/manage_categories/views/manage_categories_view.dart';
import '../modules/manage_cities/bindings/manage_cities_binding.dart';
import '../modules/manage_cities/views/manage_cities_view.dart';
import '../modules/manage_feature_requests/bindings/manage_feature_requests_binding.dart';
import '../modules/manage_feature_requests/views/manage_feature_requests_view.dart';
import '../modules/manage_requests/bindings/manage_requests_binding.dart';
import '../modules/manage_requests/views/manage_requests_view.dart';
import '../modules/manage_states/bindings/manage_states_binding.dart';
import '../modules/manage_states/views/manage_states_view.dart';
import '../modules/manage_users/bindings/manage_users_binding.dart';
import '../modules/manage_users/views/manage_users_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/my_businesses/bindings/my_businesses_binding.dart';
import '../modules/my_businesses/views/my_businesses_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/review/bindings/review_binding.dart';
import '../modules/review/views/edit_review_view.dart';
import '../modules/review/views/review_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_DETAILS,
      page: () => const BusinessDetailsView(),
      binding: BusinessDetailsBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PICKER,
      page: () => const ImagePickerView(),
      binding: ImagePickerBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME_WRAPPER,
      page: () => HomeWrapperView(),
      bindings: [
        HomeWrapperBinding(),
        HomeBinding(),
      ],
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => const ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_REVIEW,
      page: () => const EditReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.HELP_AND_SUPPORT,
      page: () => const HelpAndSupportView(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.MY_BUSINESSES,
      page: () => const MyBusinessesView(),
      binding: MyBusinessesBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BUSINESS,
      page: () => CreateBusinessView(),
      binding: CreateBusinessBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PREVIEW,
      page: () => const ImagePreviewView(),
      binding: ImagePreviewBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_REQUESTS,
      page: () => const ManageRequestsView(),
      binding: ManageRequestsBinding(),
    ),
    GetPage(
      name: _Paths.FEATURE_BUSINESS,
      page: () => const FeatureBusinessView(),
      binding: FeatureBusinessBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_FEATURE_REQUESTS,
      page: () => const ManageFeatureRequestsView(),
      binding: ManageFeatureRequestsBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_BUSINESSES,
      page: () => const ManageBusinessesView(),
      binding: ManageBusinessesBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_USERS,
      page: () => const ManageUsersView(),
      binding: ManageUsersBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_CITIES,
      page: () => const ManageCitiesView(),
      binding: ManageCitiesBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_STATES,
      page: () => const ManageStatesView(),
      binding: ManageStatesBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_CATEGORIES,
      page: () => const ManageCategoriesView(),
      binding: ManageCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageView(),
    ),
    GetPage(
      name: _Paths.EDIT_BUSINESS,
      page: () => EditBusinessView(),
      binding: EditBusinessBinding(),
    ),
    GetPage(
      name: _Paths.FEATURE_HISTORY,
      page: () => const FeatureHistoryView(),
      binding: FeatureHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PANEL,
      page: () => const AdminPanelView(),
    ),
  ];
}
