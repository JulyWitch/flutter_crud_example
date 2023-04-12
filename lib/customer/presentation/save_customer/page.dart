import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mc_crud_test/customer/presentation/save_customer/controller.dart';

import 'widgets/customer_progress_indicator.dart';
import 'widgets/first_step_form.dart';
import 'widgets/second_step_form.dart';

/// This page is used to create a new customer or update an existing one.
/// And for this reason, it is called SaveCustomerPage.
class SaveCustomerPage extends StatelessWidget {
  const SaveCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaveCustomerController(),
      builder: (context, _) {
        final SaveCustomerController controller = context.read();

        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
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
                    ),
                    const SizedBox(height: 48),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Selector<SaveCustomerController, int>(
                        selector: (p0, p1) => p1.page,
                        builder: (context, value, _) {
                          return Text(
                            value == 0
                                ? 'Personal Information'
                                : 'Bank Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        children: [
                          FirstStepForm(
                            onSavedBirthDate:
                                controller.saveField('dateOfBirth'),
                            onSavedFirstName: controller.saveField('firstName'),
                            onSavedLastName: controller.saveField('lastName'),
                          ),
                          SecondStepForm(
                            onSavedBankAccount:
                                controller.saveField('bankAccountNumber'),
                            onSavedEmail: controller.saveField('email'),
                            onSavedPhoneNumber:
                                controller.saveField('phoneNumber'),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: controller.onTapSubmit,
                        icon: const Icon(Icons.chevron_right),
                        label: const Text(
                          'Next',
                        ),
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
