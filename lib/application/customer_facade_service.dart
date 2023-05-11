import 'package:customer_management/domain/entity/customer.dart';
import 'package:customer_management/domain/interface/customer_repository.dart';

class CustomerFacadeService {
  final CustomerRepository repository;

  CustomerFacadeService({
    required this.repository,
  });

  Future<void> add(CustomerEntity customer) {
    return repository.add(customer);
  }

  Future<void> delete(CustomerEntity customer) {
    return repository.delete(customer);
  }

  Future<CustomerEntity?> get(String id) {
    return repository.get(id);
  }

  Future<List<CustomerEntity>> getAll() {
    return repository.getAll();
  }

  Future<bool> isEmailAvailable(String email) {
    return repository.isEmailAvailable(email);
  }

  Future<bool> isFirstNameLastNameBirthDateAvailable(
      String firstName, String lastName, DateTime dateOfBirth) {
    return repository.isFirstNameLastNameBirthDateAvailable(
        firstName, lastName, dateOfBirth);
  }

  Future<void> update(CustomerEntity customer) {
    return repository.update(customer);
  }
}
