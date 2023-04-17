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

  Future<void> add(CustomerEntity model) async {
    final id = uuid.v4();

    final newModel = model.copyWith(id: id);
    await Future.delayed(const Duration(milliseconds: 500));

    return box.put(id, newModel);
  }

  Future<void> update(CustomerEntity model) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return box.put(model.id, model);
  }

  Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return box.delete(id);
  }

  Future<CustomerEntity?> get(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return box.get(id);
  }

  Future<List<CustomerEntity>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return box.values.toList();
  }

  Future<bool> isEmailAvailable(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return box.values.every((element) => element.email.toLowerCase() != email.toLowerCase());
  }

  Future<bool> isFirstNameLastNameBirthDateAvailable(
      String firstName, String lastName, DateTime dateOfBirth) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return !box.values.any(
      (element) =>
          element.firstName.toLowerCase() == firstName.toLowerCase() &&
          element.lastName.toLowerCase() == lastName.toLowerCase() &&
          element.dateOfBirth == dateOfBirth,
    );
  }
}
