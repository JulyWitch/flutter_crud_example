import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:customer_management/common/mixin/state_mixin.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controller.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = CustomerListController(
          service: GetIt.I.get(),
        );

        Future.microtask(controller.init);

        return controller;
      },
      builder: (context, _) {
        final controller = context.read<CustomerListController>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Customer List'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.onTapNewCustomer(context),
            child: const Icon(Icons.add),
          ),
          body: SmartRefresher(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            child: Selector<CustomerListController, ViewStatus>(
              selector: (_, controller) {
                return controller.viewStatus;
              },
              shouldRebuild: (previous, next) => true,
              builder: (context, viewStatus, _) {
                if (viewStatus == ViewStatus.loaded) {
                  final state = controller.state;

                  if (state?.isEmpty ?? true) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/no-result.svg',
                            width: 250,
                          ),
                          const Text('No customer found'),
                          const SizedBox(height: 24),
                          OutlinedButton(
                            onPressed: () =>
                                controller.onTapNewCustomer(context),
                            child: const Text("New customer"),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state?.length,
                    itemBuilder: (context, index) {
                      final customer = state![index];

                      return ListTile(
                        title: Text(
                          '${customer.firstName} ${customer.lastName}',
                        ),
                        subtitle: Text(customer.bankAccountNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  controller.onTapEdit(context, customer),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () =>
                                  controller.onTapDelete(context, customer),
                              icon: const Icon(
                                Icons.delete_forever,
                              ),
                              color: Theme.of(context).errorColor,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
        );
      },
    );
  }
}
