import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mc_crud_test/common/mixin/state_mixin.dart';
import 'package:provider/provider.dart';

import 'controller.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = CustomerListController();

        Future.microtask(controller.init);

        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer List'),
        ),
        body: Selector<CustomerListController, ViewStatus>(
          selector: (_, controller) => controller.viewStatus,
          builder: (context, viewStatus, _) {
            if (viewStatus == ViewStatus.loaded) {
              final controller = context.read<CustomerListController>();
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
                        onPressed: () => controller.onTapNewCustomer(context),
                        child: const Text("New customer"),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state![index].firstName),
                  );
                }, 
              );
            }

            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
