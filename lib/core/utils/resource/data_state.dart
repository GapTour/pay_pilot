import 'package:pay_pilot/core/data/response/error_response.dart';

abstract class DataState<T> {
  final T? data;
  final ErrorResponse? errorResponse;

  const DataState(this.data, this.errorResponse);
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ErrorResponse? errorResponse) : super(null, errorResponse);
}
