import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class CustomerEntity extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final DateTime dateOfBirth;

  @HiveField(4)
  final BigInt phoneNumber;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String bankAccountNumber;

  const CustomerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        dateOfBirth,
        phoneNumber,
        email,
        bankAccountNumber
      ];

  CustomerEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    BigInt? phoneNumber,
    String? email,
    String? bankAccountNumber,
  }) {
    return CustomerEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
    );
  }
}
