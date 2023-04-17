import 'package:flutter/material.dart';
import 'package:mc_crud_test/common/mixin/form_mixin.dart';
import 'package:mc_crud_test/application/customer_facade_service.dart';
import 'package:mc_crud_test/domain/entity/customer.dart';

class SaveCustomerController extends ChangeNotifier with FormMixin {
  bool isButtonLoading = false;
  final PageController pageController = PageController();
  final CustomerFacadeService service;
  final CustomerEntity? initialValue;
  final GlobalKey<FormState> firstFormKey = GlobalKey();

  SaveCustomerController({
    required this.service,
    required this.initialValue,
  }) {
    init();
  }

  int page = 0;

  String? errorText;

  void init() {}

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onTapSubmit(BuildContext context) async {
    if (validateForm()) {
      final map = saveForm();
      errorText = null;
      isButtonLoading = true;

      notifyListeners();

      if (pageController.page == 0) {
        bool isPersonalInformationAvailable = true;

        if (initialValue == null) {
          isPersonalInformationAvailable =
              await service.isFirstNameLastNameBirthDateAvailable(
            map['firstName'],
            map['lastName'],
            map['dateOfBirth'],
          );
        }

        if (isPersonalInformationAvailable) {
          page = 1;
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          errorText = 'This customer already exists!';
        }
      } else if (pageController.page == 1) {
        final customer = CustomerEntity(
          id: initialValue == null ? '' : initialValue!.id,
          firstName: map['firstName'],
          lastName: map['lastName'],
          dateOfBirth: map['dateOfBirth'],
          phoneNumber:
              BigInt.parse((map['phoneNumber'] as String).replaceAll('+', '')),
          email: map['email'],
          bankAccountNumber: map['bankAccountNumber'],
        );

        Future future;
        if (initialValue == null) {
          future = service.add(customer);
        } else {
          future = service.update(customer);
        }

        await future;

        Navigator.pop(context);
      } else {
        throw UnimplementedError();
      }

      isButtonLoading = false;
      notifyListeners();
    }
  }

  void onTapBackButton(BuildContext context) {
    if (pageController.page == 0) {
      Navigator.pop(context);
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      page--;

      notifyListeners();
    }
  }

  Future<bool> isEmailAvaliable(String email) {
    return service.isEmailAvailable(email);
  }
}
