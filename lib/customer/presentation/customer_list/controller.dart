import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mc_crud_test/common/mixin/state_mixin.dart';
import 'package:mc_crud_test/customer/application/customer_facade_service.dart';
import 'package:mc_crud_test/customer/domain/entity/customer.dart';
import 'package:mc_crud_test/customer/presentation/widgets/dialogs/confirm_dialog.dart';
import 'package:mc_crud_test/customer/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerListController extends ChangeNotifier
    with StateMixin<List<CustomerEntity>> {
  final CustomerFacadeService service;

  RefreshController refreshController = RefreshController();

  CustomerListController({required this.service});

  Future<void> init([bool refreshing = false]) async {
    if(!refreshing) {
      changeState(null, viewStatus: ViewStatus.loading);
    }

    final newState = await service.getAll();

    changeState(newState, viewStatus: ViewStatus.loaded);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  Future<void> onTapNewCustomer(BuildContext context) async {
    await GoRouter.of(context).push(Routes.saveCustomer);

    init();
  }

  Future<void> onTapDelete(
      BuildContext context, CustomerEntity customer) async {
    final confirm = await showConfirmDialog(
      context,
      title: 'Delete Customer',
      message: 'Do you want to delete this customer?"',
    );

    if (confirm == true) {
      changeState(state, viewStatus: ViewStatus.loading);

      await service.delete(customer);
      await init();

      notifyListeners();
    }
  }

  Future<void> onTapEdit(BuildContext context, CustomerEntity customer) async {
    await GoRouter.of(context).push(
      Routes.saveCustomer,
      extra: customer,
    );

    init();
  }

  Future<void> onRefresh() async {
    await init(true);

    refreshController.refreshCompleted();
  }
}
