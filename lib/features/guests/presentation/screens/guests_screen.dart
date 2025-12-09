import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/guests/presentation/cubit/guests_cubit.dart';
import 'package:pay_pilot/features/guests/presentation/widgets/add_guest_dialog_box.dart';
import 'package:pay_pilot/features/guests/presentation/widgets/edit_guest_dialog_box.dart';

class GuestsScreen extends StatefulWidget {
  static const routeName = '/guests';

  const GuestsScreen({super.key});

  @override
  State<GuestsScreen> createState() => _GuestsScreenState();
}

class _GuestsScreenState extends State<GuestsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<GuestsCubit>().loadGuests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guests')),
      body: BlocBuilder<GuestsCubit, GuestsState>(
        builder: (context, state) {
          final guests = state.guests;
          final isLoading =
              state.guestsStatus == GuestsStatus.loading ||
              state.guestsStatus == GuestsStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return AppList(
            itemCount: guests.length,
            emptyInboxMessage: 'There is no guest yet!',
            itemBuilder: (context, index) {
              return AppTile(
                height: 56,
                onPreview: () {
                  // context.pushNamed(
                  //   AppRoutes.memberDetailsScreen,
                  //   pathParameters: {
                  //     AppArguments.guestDetails: '${guests[index].id}',
                  //   },
                  // );
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EditGuestDialogBox(
                        guest: guests[index],
                        onPressedSubmit: (guest) {
                          context.read<GuestsCubit>().updateGuest(guest);
                        },
                      );
                    },
                  );
                },
                onDelete: () {
                  context.read<GuestsCubit>().deleteGuest(guests[index].id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guests[index].name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    // Gap(3),
                    // Text.rich(
                    //   TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Join at: ',
                    //         style: Theme.of(context).textTheme.headlineSmall,
                    //       ),
                    //       if (guests[index].joinAt != null)
                    //         TextSpan(
                    //           text: members[index]
                    //               .joinAt!
                    //               .formattedToJalali_yearMonth,
                    //           style: Theme.of(context).textTheme.displayMedium,
                    //         )
                    //       else
                    //         TextSpan(
                    //           text: '-',
                    //           style: Theme.of(context).textTheme.headlineSmall,
                    //         ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddGuestDialogBox(
                onPressedSubmit: (guest) {
                  context.read<GuestsCubit>().addGuest(guest);
                },
              );
            },
          );
        },
        backgroundColor: kSecondaryColor,
        splashColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
