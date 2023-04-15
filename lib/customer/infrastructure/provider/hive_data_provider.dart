import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_crud_test/customer/domain/entity/customer.dart';
import 'package:uuid/uuid.dart';

const _boxName = 'customer';

class HiveDataProvider {
  late final Box<CustomerEntity> box;

  final Uuid uuid;
  HiveDataProvider({
    required this.uuid,
  });

  Future<void> init() async {
    Hive.registerAdapter(CustomerEntityAdapter());
    box = await Hive.openBox<CustomerEntity>(_boxName);
  }

  Future<void> add(CustomerEntity model) {
    final id = uuid.v4();

    final newModel = model.copyWith(id: id);

    return box.put(id, newModel);
  }

  Future<void> update(CustomerEntity model) {
    return box.put(model.id, model);
  }

  Future<void> delete(String id) {
    return box.delete(id);
  }

  CustomerEntity? get(String id) {
    return box.get(id);
  }

  Future<List<CustomerEntity>> getAll() async {
    return box.values.toList();
  }

  bool isEmailAvailable(String email) {
    return !box.values.any((element) => element.email != email);
  }

  bool isFirstNameLastNameBirthDateAvailable(
      String firstName, String lastName, DateTime dateOfBirth) {
    return !box.values.any(
      (element) =>
          element.firstName == firstName &&
          element.lastName == lastName &&
          element.dateOfBirth == dateOfBirth,
    );
  }
}
