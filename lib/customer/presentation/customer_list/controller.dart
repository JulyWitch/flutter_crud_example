import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mc_crud_test/common/mixin/state_mixin.dart';
import 'package:mc_crud_test/customer/application/customer_facade_service.dart';
import 'package:mc_crud_test/customer/domain/entity/customer.dart';
import 'package:mc_crud_test/customer/routes.dart';

class CustomerListController extends ChangeNotifier
    with StateMixin<List<CustomerEntity>> {
  final CustomerFacadeService service;

  CustomerListController({required this.service});

  Future<void> init() async {
    changeState(null, viewStatus: ViewStatus.loading);

    final newState = await service.getAll();

    changeState(newState, viewStatus: ViewStatus.loaded);
  }

  Future<void> onTapNewCustomer(BuildContext context) async {
    await GoRouter.of(context).push(Routes.saveCustomer);

    init();
  }
}
