import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';

class ResponseMenu {
  final int id;
  final String title;
  final bool isActive;

  ResponseMenu({required this.id, required this.title, required this.isActive});

  factory ResponseMenu.fromApi(Map<String, dynamic> map) {
    return ResponseMenu(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      isActive: map['is_active'] as String == '1',
    );
  }

  factory ResponseMenu.fromParams(MenuParams params) {
    return ResponseMenu(
      id: params.id!,
      title: params.title,
      isActive: params.isActive ?? true,
    );
  }

  factory ResponseMenu.fromDb(MenusData menuItem) {
    return ResponseMenu(
      id: menuItem.id,
      title: menuItem.title,
      isActive: menuItem.isActive,
    );
  }
}
