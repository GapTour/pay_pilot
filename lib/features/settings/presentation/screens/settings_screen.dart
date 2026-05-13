import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/features/settings/presentation/bloc/backup_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          BlocConsumer<BackupBloc, BackupState>(
            listener: (context, state) {
              if (state is BackupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Operation failed: $state')),
                );
              } else if (state is BackupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Operation completed successfully!'),
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
                        'Generate Backup',
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
                        'Restore Backup',
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
