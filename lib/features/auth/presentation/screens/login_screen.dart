import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.loginStatus is LoginSucceed) {
                context.goNamed(AppRoutes.mainScreen);
              }
              if (state.splashStatus is SplashChangedStatusSuccessfully) {
                context.goNamed(AppRoutes.mainScreen);
              }
            },
            builder: (context, state) {
              final isLoading =
                  state.loginStatus is LoginLoading ||
                  state.splashStatus is SplashLoading;

              if (state.loginStatus is LoginFailed) {
                errorMessage = (state.loginStatus as LoginFailed).message;
              }

              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login to you account...'),
                    Gap(25),
                    AppTextField(
                      label: 'Email',
                      hint: 'example@gmail.com',
                      autoFocus: true,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    Gap(5),
                    AppTextField(
                      label: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
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
                                LoginToAccount(
                                  LoginParams(
                                    email: emailController.text,
                                    password: passwordController.text,
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
                                    'Login',
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
                        TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.registerScreen);
                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                    AppElevatedButton(
                      onTap: () {
                        context.read<AuthBloc>().add(SetModeStatus(true));
                      },
                      isSelected: isLoading,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Switch to Offline Mode',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                      ),
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
