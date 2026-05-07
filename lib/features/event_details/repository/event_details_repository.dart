import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/data/sources/local_event_details_source.dart';
import 'package:pay_pilot/features/event_details/data/sources/remote_event_details_source.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EventDetailsRepository {
  final LocalEventDetailsSource _localEventDetailsSource;
  final RemoteEventDetailsSource _remoteEventDetailsSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  EventDetailsRepository(
    LocalEventDetailsSource localEventDetailsSource,
    RemoteEventDetailsSource remoteEventDetailsSource,
    SharedPreferencesService preferencesService,
  ) : _localEventDetailsSource = localEventDetailsSource,
      _remoteEventDetailsSource = remoteEventDetailsSource,
      _preferencesService = preferencesService;

  Future<DataState<ResponseEventDetails>> getEvent(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.getEvent(id);
      return await _remoteEventDetailsSource.getEvent(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseEventTransaction>>> insertTransaction(
    List<TransactionParams> params,
  ) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.insertTransaction(params);
      }
      return await _remoteEventDetailsSource.insertTransaction(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseOrder>> insertOrder(EventOrderParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.insertOrder(params);
      return await _remoteEventDetailsSource.insertOrder(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseEventRatio>> insertRatio(
    EventRatioParams params,
  ) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.insertRatio(params);
      return await _remoteEventDetailsSource.insertRatio(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseEventTransaction>> updateTransaction(
    TransactionParams params,
  ) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.updateTransaction(params);
      }
      return await _remoteEventDetailsSource.updateTransaction(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseOrder>> updateOrder(EventOrderParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.updateOrder(params);
      return await _remoteEventDetailsSource.updateOrder(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseOrder>> changeOrderStatus(
    int id,
    bool isDelivered,
  ) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.changeOrderStatus(
          id,
          isDelivered,
        );
      }
      return await _remoteEventDetailsSource.changeOrderStatus(id, isDelivered);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<int>> deleteTransaction(TransactionParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.deleteTransaction(params);
      }
      return await _remoteEventDetailsSource.deleteTransaction(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<int>> deleteOrder(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.deleteOrder(id);
      return await _remoteEventDetailsSource.deleteOrder(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseEventRatio>> updateEventRatio(
    EventRatioParams params,
  ) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.updateEventRatio(params);
      }
      return await _remoteEventDetailsSource.updateEventRatio(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<int>> deleteEventRatio(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.deleteEventRatio(id);
      }
      return await _remoteEventDetailsSource.deleteEventRatio(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.getAllMembers();
      return await _remoteEventDetailsSource.getAllMembers();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.getAllGuests();
      return await _remoteEventDetailsSource.getAllGuests();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseOrder>>> getAllOrders(int eventID) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localEventDetailsSource.getAllOrders(eventID);
      }
      return await _remoteEventDetailsSource.getAllOrders(eventID);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseMenu>>> getAllMenuItems() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventDetailsSource.getAllMenuItems();
      return await _remoteEventDetailsSource.getAllMenuItems();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
