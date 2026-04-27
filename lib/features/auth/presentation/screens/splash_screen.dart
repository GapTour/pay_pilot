import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_settings.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/features/auth/presentation/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.splashStatus != c.splashStatus,
      listener: (context, state) {
        if (state.splashStatus is SplashAuthenticated ||
            state.splashStatus is SplashChangedStatusSuccessfully) {
          context.goNamed(AppRoutes.mainScreen);
        }
        if (state.splashStatus is SplashNotAuthenticated) {
          context.goNamed(AppRoutes.loginScreen);
        }
        if (state.splashStatus is SplashNeedUpdate) {
          // TODO(mahDyarZ): handle need update here and remove go to login
          context.goNamed(AppRoutes.loginScreen);
        }
      },
      buildWhen: (p, c) => p.splashStatus != c.splashStatus,
      builder: (context, state) {
        final isLoading = state.splashStatus is SplashLoading;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Expanded(child: Image.asset('assets/icons/ic_launcher.png')),
                Gap(16),

                AppElevatedButton(
                  onTap: () {
                    context.read<AuthBloc>().add(CheckAuthStatus());
                  },
                  isSelected: isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Online Mode',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(5),
                AppElevatedButton(
                  onTap: () {
                    context.read<AuthBloc>().add(SetModeStatus(true));
                  },
                  isSelected: isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Offline Mode',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(28),
                Text(
                  'Version ${AppSettings.version}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (isLoading) ...[
                  Gap(8),
                  LoadingAnimationWidget.threeArchedCircle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                ] else
                  SizedBox(height: 42),

                Gap(height * .1),
              ],
            ),
          ),
        );
      },
    );
  }
}
