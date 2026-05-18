import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';
import 'package:pay_pilot/features/menu/repository/menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository _repository;
  MenuCubit(this._repository)
    : super(MenuState(menuStatus: MenuStatus.initial, menuItems: []));

  void loadMenuItems() async {
    emit(state.copyWith(menuStatus: MenuStatus.loading));

    final dataState = await _repository.getAllItems();

    if (dataState is DataSuccess) {
      final menuItems = dataState.data!;

      menuItems.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      emit(
        state.copyWith(menuStatus: MenuStatus.success, menuItems: menuItems),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(menuStatus: MenuStatus.failure));
    }
  }

  void addMenuItem(MenuParams params) async {
    final menuItems = state.menuItems;
    emit(state.copyWith(menuStatus: MenuStatus.loading));

    final dataState = await _repository.addMenuItem(params);
    if (dataState is DataSuccess) {
      final newItem = dataState.data!;

      menuItems
        ..add(newItem)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(menuStatus: MenuStatus.success, menuItems: menuItems),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(menuStatus: MenuStatus.failure));
    }
  }

  void updateItem(MenuParams params) async {
    final menuItems = state.menuItems;
    emit(state.copyWith(menuStatus: MenuStatus.loading));

    final dataState = await _repository.editMenuItem(params);

    if (dataState is DataSuccess) {
      final updatedItem = dataState.data!;

      menuItems
        ..removeWhere((element) => element.id == updatedItem.id)
        ..add(updatedItem)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(menuStatus: MenuStatus.success, menuItems: menuItems),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(menuStatus: MenuStatus.failure));
    }
  }

  void deleteItem(int itemID) async {
    final menuItems = state.menuItems;
    emit(state.copyWith(menuStatus: MenuStatus.loading));

    final dataState = await _repository.deleteMenuItem(itemID);

    if (dataState is DataSuccess) {
      menuItems.removeWhere((element) => element.id == itemID);

      emit(
        state.copyWith(menuStatus: MenuStatus.success, menuItems: menuItems),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(menuStatus: MenuStatus.failure));
    }
  }
}
