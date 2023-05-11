import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:customer_management/domain/entity/customer.dart';
import 'package:customer_management/presentation/save_customer/controller.dart';

import 'widgets/customer_progress_indicator.dart';
import 'widgets/first_step_form.dart';
import 'widgets/second_step_form.dart';

/// This page is used to create a new customer or update an existing one.
/// And for this reason, it is called SaveCustomerPage.
class SaveCustomerPage extends StatelessWidget {
  const SaveCustomerPage({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  final CustomerEntity? initialValue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaveCustomerController(
        service: GetIt.I.get(),
        initialValue: initialValue,
      ),
      builder: (context, _) {
        final SaveCustomerController controller = context.read();

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => controller.onTapBackButton(context),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        if (isKeyboardVisible) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Selector<SaveCustomerController, int>(
                                selector: (p0, p1) => p1.page,
                                builder: (context, value, _) {
                                  return CustomerProgressIndicator(
                                    progress: value == 0 ? 0.5 : 1,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Selector<SaveCustomerController, int>(
                        selector: (p0, p1) => p1.page,
                        builder: (context, value, _) {
                          return Text(
                            value == 0
                                ? 'Personal Information'
                                : 'Extra Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: [
                          FirstStepForm(
                            initialFirstName: initialValue?.firstName,
                            initialLastName: initialValue?.lastName,
                            initialBirthDate: initialValue?.dateOfBirth,
                            onSavedBirthDate:
                                controller.saveField('dateOfBirth'),
                            onSavedFirstName: controller.saveField('firstName'),
                            onSavedLastName: controller.saveField('lastName'),
                          ),
                          SecondStepForm(
                            initiaBankAccount: initialValue?.bankAccountNumber,
                            initialEmail: initialValue?.email,
                            initialPhoneNumber:
                                initialValue?.formattedPhoneNumber,
                            onSavedBankAccount:
                                controller.saveField('bankAccountNumber'),
                            onSavedEmail: controller.saveField('email'),
                            onSavedPhoneNumber:
                                controller.saveField('phoneNumber'),
                            isEmailAvaliable: controller.isEmailAvaliable,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Selector<SaveCustomerController, String?>(
                      selector: (p0, p1) => p1.errorText,
                      builder: (context, value, child) {
                        if (value == null) {
                          return const SizedBox();
                        }

                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(value,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  )),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Consumer<SaveCustomerController>(
                        builder: (context, controller, child) {
                          return ElevatedButton.icon(
                            key: const ValueKey('submitButton'),
                            onPressed: controller.isButtonLoading
                                ? null
                                : () => controller.onTapSubmit(context),
                            icon: const Icon(Icons.chevron_right),
                            label: Text(
                              controller.page == 0 ? 'Next' : 'Save',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
