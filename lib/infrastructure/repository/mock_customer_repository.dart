import 'package:mc_crud_test/domain/entity/customer.dart';
import 'package:mc_crud_test/domain/interface/customer_repository.dart';

// A mock repository for customer repository
class MockCustomerRepository extends CustomerRepository {
  // A list of customer entities
  final List<CustomerEntity> _customers = [];

  // A list of customer entities
  List<CustomerEntity> get customers => _customers;

  // Return the customer entity with the given id
  @override
  Future<CustomerEntity?> get(String id) async {
    return _customers.firstWhere((element) => element.id == id);
  }

  // Return all customer entities
  @override
  Future<List<CustomerEntity>> getAll() async {
    return _customers;
  }

  // Add the given customer entity to the repository
  @override
  Future<void> add(CustomerEntity customer) async {
    _customers.add(customer);
  }

  // Update the given customer entity in the repository
  @override
  Future<void> update(CustomerEntity customer) async {
    final index = _customers.indexWhere((element) => element.id == customer.id);

    if (index != -1) {
      _customers[index] = customer;
    }
  }

  // Delete the given customer entity from the repository
  @override
  Future<void> delete(CustomerEntity customer) async {
    _customers.removeWhere((element) => element.id == customer.id);
  }

  // Return true if the given email is available
  @override
  Future<bool> isEmailAvailable(String email) async {
    return _customers
        .every((element) => element.email.toLowerCase() != email.toLowerCase());
  }

  // Return true if the given first name, last name and birth date are available
  @override
  Future<bool> isFirstNameLastNameBirthDateAvailable(
      String firstName, String lastName, DateTime dateOfBirth) async {
    return !_customers.any((element) =>
        element.firstName.toLowerCase() == firstName.toLowerCase() &&
        element.lastName.toLowerCase() == lastName.toLowerCase() &&
        element.dateOfBirth == dateOfBirth);
  }
}
