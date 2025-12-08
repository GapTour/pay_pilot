import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_settings.dart';
import 'package:pay_pilot/features/auth/presentation/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.splashStatus != c.splashStatus,
      listener: (context, state) {
        if (state.splashStatus is SplashAuthenticated) {
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
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Image.asset('assets/icons/ic_launcher.png')),
            LoadingAnimationWidget.threeArchedCircle(
              color: Theme.of(context).colorScheme.onPrimary,
              size: 32,
            ),
            Gap(8),
            Text(
              'Version ${AppSettings.version}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Gap(height * .1),
          ],
        ),
      ),
    );
  }
}
