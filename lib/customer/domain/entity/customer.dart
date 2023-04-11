import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final BigInt phoneNumber;
  final String email;
  final String bankAccountNumber;

  const CustomerEntity({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });
  @override
  List<Object?> get props =>
      [firstname, lastname, dateOfBirth, phoneNumber, email, bankAccountNumber];
}
