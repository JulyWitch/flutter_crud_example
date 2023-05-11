import 'package:go_router/go_router.dart';
import 'package:customer_management/domain/entity/customer.dart';
import 'package:customer_management/presentation/customer_list/page.dart';
import 'package:customer_management/presentation/save_customer/page.dart';

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
        builder: (context, state) => SaveCustomerPage(
          initialValue: state.extra as CustomerEntity?,
        ),
      ),
    ],
  );
}
