import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banksampah/config/config.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routesProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteLocation.dashboard,
      navigatorKey: navigationKey,
      routes: appRoutes,
    );
  },
);
