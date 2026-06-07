import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/core/widgets/app_modal_bottom_sheet.dart';
import 'package:pay_pilot/features/change_language/presentation/widgets/change_language_modal_view.dart';
import 'package:pay_pilot/features/settings/presentation/bloc/backup_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.settings_appBarTitle)),
      body: ListView(
        children: [
          BlocConsumer<BackupBloc, BackupState>(
            listener: (context, state) {
              if (state is BackupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${S.current.warning_operationFailure} $state',
                    ),
                  ),
                );
              } else if (state is BackupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.current.warning_operationSuccessful),
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is BackupInProgress;

              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(18),
                children: [
                  AppElevatedButton(
                    isSelected: isLoading,
                    onTap: () {
                      context.read<BackupBloc>().add(BackupRequested());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.current.button_title_backup,
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  AppElevatedButton(
                    isSelected: isLoading,
                    onTap: () {
                      context.read<BackupBloc>().add(RestoreRequested());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.current.button_title_restore,
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  AppElevatedButton(
                    onTap: () {
                      AppModalBottomSheet.minHeightWithAppBar(
                        header: S.current.button_title_changeLanguage,
                        child: ChangeLanguageModalView(),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.current.modalBottom_title_changeLanguage,
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
