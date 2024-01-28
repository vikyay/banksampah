import 'package:banksampah/config/config.dart';
import 'package:banksampah/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRoutes = [
  GoRoute( //homescreen tidak dipake lagi
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute( //dashboard
    path: RouteLocation.dashboard,
    parentNavigatorKey: navigationKey,
    builder: Dashboard.builder,
  ),
  GoRoute( //buat baru
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
  GoRoute( //daftar kategori
    path: RouteLocation.kategoribrg,
    parentNavigatorKey: navigationKey,
    builder: KategoriBarang.builder,
  ),
];
