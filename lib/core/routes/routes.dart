import 'package:furniture_e_commerce/aboutUs/about_us.dart';
import 'package:furniture_e_commerce/contactUs/contact_us.dart';
import 'package:furniture_e_commerce/core/features/auth/view/login_view.dart';
import 'package:furniture_e_commerce/core/features/auth/view/signup_view.dart';
import 'package:furniture_e_commerce/core/features/auth/wrapper/auth_wrapper.dart';
import 'package:furniture_e_commerce/core/features/main/cart/cart.dart';
import 'package:furniture_e_commerce/core/features/main/home/screeen/home.dart';
import 'package:furniture_e_commerce/core/features/main/productDetail/product_details.dart';
import 'package:furniture_e_commerce/core/features/main/profile/components/order_view.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/features/main/profile/screen/profile.dart';
import 'package:furniture_e_commerce/core/features/main/profile/screen/profile_update_form.dart';
import 'package:furniture_e_commerce/core/features/main/view/main_view.dart';
import 'package:furniture_e_commerce/core/features/splash/view/splash_view.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/termsAndConditions/terms_conditions.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteName.splashView,
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
        name: RouteName.signUpView,
        path: '/signUp',
        builder: (context, state) => const SignupView()),
    GoRoute(
        name: RouteName.loginView,
        path: '/login',
        builder: (context, state) => const LoginView()),
    GoRoute(
        name: RouteName.authWrapper,
        path: '/auth-wrappper',
        builder: (context, state) => const AuthWrapper()),
    GoRoute(
        name: RouteName.mainView,
        path: '/main-view',
        builder: (context, state) => const MainView()),
    GoRoute(
        name: RouteName.cartView,
        path: '/cart-view',
        builder: (context, state) => const Cart()),
    GoRoute(
      name: RouteName.homeView,
      path: '/home-view',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      name: RouteName.profileView,
      path: '/profile-view',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      name: RouteName.editProfileView,
      path: '/edit-profile',
      builder: (context, state) => const ProfileUpdateForm(),
    ),
    GoRoute(
      name: RouteName.productDetailView,
      path: '/product-detail',
      builder: (context, state) => ProductDetails(item: state.extra as Items),
    ),
    GoRoute(
      name: RouteName.termsAndConditionsView,
      path: '/terms-and-conditions',
      builder: (context, state) => const TermsAndConditionsView(),
    ),
    GoRoute(
      name: RouteName.contactUsView,
      path: '/contact-us',
      builder: (context, state) => const ContactUsView(),
    ),
    GoRoute(
      name: RouteName.aboutUsView,
      path: '/about-us',
      builder: (context, state) => const AboutUsView(),
    ),
    GoRoute(
      name: RouteName.orderView,
      path: '/order-view',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return OrderScreen(userId: extra?['userId'] as String);
      },
    ),
  ],
);
