import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_pilot/core/data/params/register_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.registerStatus is RegisterSucceed) {
                context.pop();
              }
            },
            builder: (context, state) {
              final isLoading = state.registerStatus is RegisterLoading;

              if (state.registerStatus is RegisterFailed) {
                errorMessage = (state.registerStatus as RegisterFailed).message;
              }

              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.current.register_appBarTitle),
                    Gap(25),
                    AppTextField(
                      label: S.current.textField_label_email,
                      hint: 'example@gmail.com',
                      autoFocus: true,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.current.validator_required;
                        }
                        return null;
                      },
                    ),
                    Gap(5),
                    AppTextField(
                      label: S.current.textField_label_password,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.current.validator_required;
                        }
                        return null;
                      },
                    ),
                    Gap(5),
                    AppTextField(
                      label: S.current.textField_label_repeatPassword,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.current.validator_required;
                        }
                        if (value != confirmPasswordController.text) {
                          return S.current.validator_passwordNotMatch;
                        }
                        return null;
                      },
                    ),
                    Spacer(),
                    if (errorMessage != null) ...[
                      Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      Gap(12),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            onTap: () {
                              if (!formKey.currentState!.validate()) return;
                              context.read<AuthBloc>().add(
                                RegisterNewAccount(
                                  RegisterParams(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    permissionID: 1,
                                  ),
                                ),
                              );
                            },
                            isSelected: isLoading,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isLoading) ...[
                                    LoadingAnimationWidget.threeArchedCircle(
                                      color: kPrimaryContainerColor,
                                      size: 16,
                                    ),
                                    Gap(5),
                                  ],
                                  Text(
                                    S.current.button_title_register,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AppElevatedButton(
                          onTap: () {
                            context.read<AuthBloc>().add(CreateNewPermission());
                          },
                          isSelected: isLoading,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.verified_user_rounded),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.pop();
                                },
                          child: Text(S.current.button_title_backToLogin),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
