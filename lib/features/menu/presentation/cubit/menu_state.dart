part of 'menu_cubit.dart';

enum MenuStatus { initial, loading, success, failure }

class MenuState extends Equatable {
  final MenuStatus menuStatus;
  final List<ResponseMenu> menuItems;
  const MenuState({required this.menuStatus, required this.menuItems});

  @override
  List<Object> get props => [menuStatus, menuItems];

  MenuState copyWith({MenuStatus? menuStatus, List<ResponseMenu>? menuItems}) {
    return MenuState(
      menuStatus: menuStatus ?? this.menuStatus,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}
