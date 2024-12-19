import 'package:barcode_scanner_app/src/features/permission/routes/permission_routes.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: PermissionRoutes.permisson,
    routes: [
      ...PermissionRoutes.routes,
      // ...DecibelRoutes.routes,
      // ...SettingRoutes.routes,
    ],
  );
}
