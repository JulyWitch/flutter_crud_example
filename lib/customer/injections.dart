import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_crud_test/customer/application/customer_facade_service.dart';
import 'package:mc_crud_test/customer/domain/interface/customer_repository.dart';
import 'package:mc_crud_test/customer/infrastructure/provider/hive_data_provider.dart';
import 'package:mc_crud_test/customer/infrastructure/repository/customer_repository.dart';
import 'package:uuid/uuid.dart';

final serviceLocator = GetIt.instance;

Future<void> ensureInitialized() async {
  await Hive.initFlutter();
  
  serviceLocator.registerSingletonAsync(() async {
    final instance = HiveDataProvider(uuid: const Uuid());

    await instance.init();

    return instance;
  });

  serviceLocator.registerSingletonWithDependencies<CustomerRepository>(
    () => CustomerRepositoryImpl(dataProvider: serviceLocator()),
    dependsOn: [HiveDataProvider],
  );

  serviceLocator.registerSingletonWithDependencies(
    () => CustomerFacadeService(
      repository: serviceLocator(),
    ),
    dependsOn: [CustomerRepository],
  );

  await serviceLocator.allReady();
}
