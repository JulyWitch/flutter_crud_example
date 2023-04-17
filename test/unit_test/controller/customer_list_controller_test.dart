import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/application/customer_facade_service.dart';
import 'package:mc_crud_test/common/mixin/state_mixin.dart';
import 'package:mc_crud_test/presentation/customer_list/controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import 'customer_list_controller.mocks.dart';

@GenerateMocks([CustomerFacadeService])
void main() {
  late CustomerListController controller;
  late CustomerFacadeService service;

  setUp(() {
    service = MockCustomerFacadeService();
    controller = CustomerListController(service: service);
  });

  group('CustomerListController', () {
    test(
      'Given the initial state, When call init(), Then controller should get to loading and then loaded state',
      () async {
        when(service.getAll()).thenAnswer(
          (realInvocation) => Future.delayed(
            const Duration(milliseconds: 500),
            () => customers,
          ),
        );

        final future = controller.init();

        expect(controller.viewStatus, ViewStatus.loading);

        await future;

        expect(controller.viewStatus, ViewStatus.loaded);
      },
    );
  });
}
