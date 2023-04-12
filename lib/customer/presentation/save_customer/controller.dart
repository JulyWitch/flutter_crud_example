import 'package:flutter/material.dart';
import 'package:mc_crud_test/common/mixin/form_mixin.dart';

class SaveCustomerController extends ChangeNotifier with FormMixin {
  bool isButtonLoading = false;
  final PageController pageController = PageController();

  SaveCustomerController() {
    init();
  }

  int page = 0;

  void init() {}

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTapSubmit() {
    if (validateForm()) {
      saveForm();

      if (pageController.page == 0) {
        page = 1;
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );

        notifyListeners();
      } else if (pageController.page == 1) {
        
      } else {
        throw UnimplementedError();
      }
    }
  }
}
