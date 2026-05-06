import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/menu_dao/menu_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';
import 'package:pay_pilot/features/menu/data/sources/i_menu_source.dart';

class LocalMenuSource implements IMenuSource {
  final MenuDao _dbService;
  LocalMenuSource(this._dbService);

  @override
  Future<DataState<ResponseMenu>> addMenuItem(MenuParams params) async {
    try {
      final response = await _dbService.insertItem(params);
      final member = ResponseMenu.fromParams(params.copyWith(id: response));

      return DataSuccess(member);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteMenuItem(int id) async {
    try {
      await _dbService.deleteItem(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseMenu>> editMenuItem(MenuParams params) async {
    try {
      await _dbService.updateMenu(params);
      final member = ResponseMenu.fromParams(params);

      return DataSuccess(member);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMenu>>> getAllItems() async {
    try {
      final response = await _dbService.getAllMenus();
      final members = response.map(ResponseMenu.fromDb).toList();

      return DataSuccess(members);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
