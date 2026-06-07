import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/enums/language_code.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/features/change_language/presentation/cubit/language_cubit.dart';

class ChangeLanguageModalView extends StatefulWidget {
  const ChangeLanguageModalView({super.key});

  @override
  State<ChangeLanguageModalView> createState() =>
      _ChangeLanguageModalViewState();
}

class _ChangeLanguageModalViewState extends State<ChangeLanguageModalView> {
  late LanguageCode _language;

  @override
  void initState() {
    super.initState();
    final materialState = context
        .read<LanguageCubit>()
        .state
        .materialLanguageStatus;

    _language = (materialState as MaterialChangingSuccess).code;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listenWhen: (p, c) =>
          p.languageChangingStatus != c.languageChangingStatus,
      buildWhen: (p, c) => p.languageChangingStatus != c.languageChangingStatus,
      listener: (context, state) {
        if (state.languageChangingStatus is LanguageChangingSuccess) {
          context
            ..pop()
            ..read<LanguageCubit>().changeLanguageToInit();
        }
      },
      builder: (context, state) {
        final isLoading =
            state.languageChangingStatus is LanguageChangingLoading ||
            state.languageChangingStatus is LanguageChangingSuccess;

        return Column(
          children: [
            TextButton(
              onPressed: () {
                _language = LanguageCode.persian;
                setState(() {});
              },
              child: Row(
                children: [
                  Expanded(child: Text('فارسی')),
                  if (_language.isPersian)
                    Icon(Icons.check_circle_outline_outlined),
                ],
              ),
            ),
            Gap(8),
            TextButton(
              onPressed: () {
                _language = LanguageCode.english;
                setState(() {});
              },
              child: Row(
                children: [
                  Expanded(child: Text('English')),
                  if (_language.isEnglish)
                    Icon(Icons.check_circle_outline_outlined),
                ],
              ),
            ),
            Gap(25),
            AppElevatedButton(
              size: Size(double.infinity, 48),
              onTap: () {
                context.read<LanguageCubit>().changeLanguage(_language);
              },
              isSelected: isLoading,
              child: Center(child: Text(S.current.button_title_submit)),
            ),
          ],
        );
      },
    );
  }
}
