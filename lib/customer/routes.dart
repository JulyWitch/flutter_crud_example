import 'package:go_router/go_router.dart';
import 'package:mc_crud_test/customer/presentation/customer_list/page.dart';
import 'package:mc_crud_test/customer/presentation/save_customer/page.dart';

class Routes {
  static const customerList = '/customer';
  static const saveCustomer = '/customer/save';

  static final router = GoRouter(
    initialLocation: customerList,
    routes: [
      GoRoute(
        path: customerList,
        builder: (context, state) => const CustomerListPage(),
      ),
      GoRoute(
        path: saveCustomer,
        builder: (context, state) => const SaveCustomerPage(),
      ),
    ],
  );
}
