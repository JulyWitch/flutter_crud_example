import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_crud_test/application/customer_facade_service.dart';
import 'package:mc_crud_test/config/main.dart';
import 'package:mc_crud_test/domain/interface/customer_repository.dart';
import 'package:mc_crud_test/infrastructure/provider/hive_data_provider.dart';
import 'package:mc_crud_test/infrastructure/repository/customer_repository.dart';
import 'package:mc_crud_test/infrastructure/repository/mock_customer_repository.dart';
import 'package:uuid/uuid.dart';

final serviceLocator = GetIt.instance;

Future<void> ensureInitialized() async {
  if (appEnv.isDevelopment) {
    _registerDevelopmentDependencies();
  } else if (appEnv.isProduction) {
    await Hive.initFlutter();

    _registerProductionDependencies();
  }

  await serviceLocator.allReady();
}

void _registerProductionDependencies() {
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
}

void _registerDevelopmentDependencies() {
  serviceLocator.registerLazySingleton<CustomerRepository>(
    () => MockCustomerRepository(),
  );

  serviceLocator.registerLazySingleton(
    () => CustomerFacadeService(
      repository: serviceLocator(),
    ),
  );
}
