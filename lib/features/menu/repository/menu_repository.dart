import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';
import 'package:pay_pilot/features/menu/data/sources/i_menu_source.dart';
import 'package:pay_pilot/features/menu/data/sources/local_menu_source.dart';
import 'package:pay_pilot/features/menu/data/sources/remote_menu_source.dart';

abstract class IMenuRepository implements IMenuSource {}

class MenuRepository implements IMenuRepository {
  final LocalMenuSource _localMenuSource;
  final RemoteMenuSource _remoteMenuSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  MenuRepository(
    LocalMenuSource localMenuSource,
    RemoteMenuSource remoteMenuSource,
    SharedPreferencesService preferencesService,
  ) : _localMenuSource = localMenuSource,
      _remoteMenuSource = remoteMenuSource,
      _preferencesService = preferencesService;

  @override
  Future<DataState<List<ResponseMenu>>> getAllItems() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localMenuSource.getAllItems();
      return await _remoteMenuSource.getAllItems();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseMenu>> addMenuItem(MenuParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localMenuSource.addMenuItem(params);
      return await _remoteMenuSource.addMenuItem(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseMenu>> editMenuItem(MenuParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localMenuSource.editMenuItem(params);
      return await _remoteMenuSource.editMenuItem(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteMenuItem(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localMenuSource.deleteMenuItem(id);
      return await _remoteMenuSource.deleteMenuItem(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
