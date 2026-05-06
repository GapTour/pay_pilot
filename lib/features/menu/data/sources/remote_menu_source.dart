import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';
import 'package:pay_pilot/features/menu/data/providers/menu_api_provider.dart';
import 'package:pay_pilot/features/menu/data/sources/i_menu_source.dart';

class RemoteMenuSource implements IMenuSource {
  final MenuApiProvider _apiProvider;
  RemoteMenuSource(this._apiProvider);

  @override
  Future<DataState<ResponseMenu>> addMenuItem(MenuParams params) async {
    try {
      final Response response = await _apiProvider.addMenuItem(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseMenu.fromApi(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<int>> deleteMenuItem(int id) async {
    try {
      final Response response = await _apiProvider.deleteMenuItem(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseMenu>> editMenuItem(MenuParams params) async {
    try {
      final Response response = await _apiProvider.editMenuItem(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseMenu.fromApi(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<List<ResponseMenu>>> getAllItems() async {
    try {
      final Response response = await _apiProvider.getAllItems();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseMenu.fromApi(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
