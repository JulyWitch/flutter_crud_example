import 'package:mc_crud_test/domain/entity/customer.dart';
import 'package:mc_crud_test/domain/interface/customer_repository.dart';
import 'package:mc_crud_test/infrastructure/provider/hive_data_provider.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final HiveDataProvider dataProvider;

  CustomerRepositoryImpl({
    required this.dataProvider,
  });

  @override
  Future<void> add(CustomerEntity customer) {
    return dataProvider.add(customer);
  }

  @override
  Future<void> delete(CustomerEntity customer) {
    return dataProvider.delete(customer.id);
  }

  @override
  Future<CustomerEntity?> get(String id) async {
    return dataProvider.get(id);
  }

  @override
  Future<List<CustomerEntity>> getAll() async {
    return dataProvider.getAll();
  }

  @override
  Future<bool> isEmailAvailable(String email) async {
    return dataProvider.isEmailAvailable(email);
  }

  @override
  Future<bool> isFirstNameLastNameBirthDateAvailable(
      String firstName, String lastName, DateTime dateOfBirth) async {
    return dataProvider.isFirstNameLastNameBirthDateAvailable(
      firstName,
      lastName,
      dateOfBirth,
    );
  }

  @override
  Future<void> update(CustomerEntity customer) {
    return dataProvider.update(customer);
  }
}
