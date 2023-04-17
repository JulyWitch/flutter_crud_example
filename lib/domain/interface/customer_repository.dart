import 'package:mc_crud_test/domain/entity/customer.dart';

abstract class CustomerRepository {
  Future<CustomerEntity?> get(String id);
  Future<List<CustomerEntity>> getAll();
  Future<void> add(CustomerEntity customer);
  Future<void> update(CustomerEntity customer);
  Future<void> delete(CustomerEntity customer);
  Future<bool> isEmailAvailable(String email);
  Future<bool> isFirstNameLastNameBirthDateAvailable(
    String firstName,
    String lastName,
    DateTime dateOfBirth,
  );
}
