import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:pay_pilot/features/menu/presentation/widgets/add_menu_item_dialog_box.dart';
import 'package:pay_pilot/features/menu/presentation/widgets/edit_menu_item_dialog_box.dart';

class MenuItemsScreen extends StatefulWidget {
  static const routeName = '/menu-Items';
  const MenuItemsScreen({super.key});

  @override
  State<MenuItemsScreen> createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MenuCubit>().loadMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Items')),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          final items = state.menuItems;
          final isLoading =
              state.menuStatus == MenuStatus.loading ||
              state.menuStatus == MenuStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return AppList(
            itemCount: items.length,
            emptyInboxMessage: 'There is no item yet!',
            itemBuilder: (context, index) {
              return AppTile(
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EditMenuItemDialogBox(
                        menuItem: items[index],
                        onPressedSubmit: (menu) {
                          context.read<MenuCubit>().updateItem(menu);
                        },
                      );
                    },
                  );
                },
                onDelete: () {
                  context.read<MenuCubit>().deleteItem(items[index].id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[index].title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Gap(3),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Active: ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),

                          TextSpan(
                            text: '${items[index].isActive}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
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
              return AddMenuItemDialogBox(
                onPressedSubmit: (menu) {
                  context.read<MenuCubit>().addMenuItem(menu);
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
