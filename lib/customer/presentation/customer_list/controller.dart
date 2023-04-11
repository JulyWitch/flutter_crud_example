import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mc_crud_test/common/mixin/state_mixin.dart';
import 'package:mc_crud_test/customer/domain/entity/customer.dart';
import 'package:mc_crud_test/customer/routes.dart';

class CustomerListController extends ChangeNotifier
    with StateMixin<List<CustomerEntity>> {
  CustomerListController();

  Future<void> init() async {
    changeState(null, viewStatus: ViewStatus.loading);

    await Future.delayed(const Duration(milliseconds: 400));
    changeState([], viewStatus: ViewStatus.loaded);
  }

  Future<void> onTapNewCustomer(BuildContext context) async {
    await GoRouter.of(context).push(Routes.saveCustomer);

    init();
  }
}
