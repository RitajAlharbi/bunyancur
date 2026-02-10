import 'package:flutter/material.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/roles/presentation/screens/roles_screen.dart';
import '../../features/messages/views/messages_screen.dart';
import '../../features/messages/views/chat_screen.dart';
import '../../features/market/views/market_screen.dart';
import '../../features/market/add_product/views/add_product_screen.dart';
import '../../features/market/add_product/views/product_added_success_screen.dart';
import '../../features/market/add_product/models/product_form_model.dart';
import '../../features/market/product_details/views/product_details_screen.dart';
import '../../features/market/product_details/models/product_details_model.dart';
import '../../features/market/purchase_product/views/purchase_product_screen.dart';
import '../../features/market/purchase_product/models/purchase_product_model.dart';
import '../../features/client_orders/view/client_orders_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
      case Routes.splashScreen:
      case '/':
        return _createRoute(const SplashScreen());
      case Routes.roles:
        return _createRoute(const RolesScreen());
      case Routes.onBoardingScreen:
        return _createRoute(const OnboardingScreen());
      case Routes.homeScreen:
        return _createRoute(const HomeScreen());
      case Routes.clientOrdersScreen:
        return _createRoute(const ClientOrdersScreen());
      case Routes.marketScreen:
        return _createRoute(const MarketScreen());
      case Routes.addProduct:
        return _createRoute(const AddProductScreen());
      case Routes.productAddedSuccess:
        final form = settings.arguments as ProductFormModel?;
        return _createRoute(ProductAddedSuccessScreen(form: form));
      case Routes.productDetails:
        final product = settings.arguments as ProductDetailsModel?;
        return _createRoute(ProductDetailsScreen(product: product));
      case Routes.purchaseProduct:
        final product = settings.arguments as PurchaseProductModel;
        return _createRoute(PurchaseProductScreen(product: product));
      case Routes.messagesScreen:
        return _createRoute(const MessagesScreen());
      case Routes.chatScreen:
        final threadId = settings.arguments as String? ?? '';
        return _createRoute(ChatScreen(threadId: threadId));

      default:
        return null;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
