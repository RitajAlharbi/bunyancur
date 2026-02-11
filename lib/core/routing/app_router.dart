import 'package:flutter/material.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/roles/presentation/screens/roles_screen.dart';
import '../../features/contractor/view/contractor_home_view.dart';
import '../../features/projects/view/projects_screen.dart';
import '../../features/projects/view/available_projects_screen.dart';
import '../../features/projects/view/contractor_project_details_screen.dart';
import '../../features/projects/model/project_status.dart';
import '../../models/project_model.dart';
import '../../features/favorites/view/favorites_screen.dart';
import '../../features/notifications/view/notifications_screen.dart';

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
      case Routes.contractorHomeView:
        return _createRoute(const ContractorHomeView());
      case Routes.projectsScreen: {
        final index = settings.arguments as int?;
        final initialFilter = index != null && index >= 0 && index < 4
            ? ProjectStatus.values[index]
            : null;
        return _createRoute(ProjectsScreen(initialFilter: initialFilter));
      }
      case Routes.availableProjectsScreen:
        return _createRoute(const AvailableProjectsScreen());
      case Routes.contractorProjectDetailsScreen: {
        final project = settings.arguments as ProjectModel?;
        if (project == null) return null;
        return _createRoute(ContractorProjectDetailsScreen(project: project));
      }
      case Routes.favoritesScreen:
        return _createRoute(const FavoritesScreen());
      case Routes.notificationsScreen:
        return _createRoute(const NotificationsScreen());

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
