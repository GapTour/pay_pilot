import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

abstract class IMenuSource {
  Future<DataState<List<ResponseMenu>>> getAllItems();
  Future<DataState<ResponseMenu>> addMenuItem(MenuParams params);
  Future<DataState<ResponseMenu>> editMenuItem(MenuParams params);
  Future<DataState<int>> deleteMenuItem(int id);
}
