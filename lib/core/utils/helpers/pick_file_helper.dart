import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';

class PickFileHelper {
  static Future<DataState<Uint8List>> pickJsonFile() async {
    try {
      late Uint8List bytes;
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );

      if (result == null) {
        return DataFailed(
          ErrorResponse(
            message: 'No file selected',
            status: 'Failed',
            code: 600,
            data: '',
          ),
        );
      }

      final pickedFile = result.files.single;

      if (pickedFile.bytes == null && !kIsWeb) {
        bytes = await File(pickedFile.path!).readAsBytes();

        return DataSuccess(bytes);
      }

      if (pickedFile.bytes != null) {
        bytes = pickedFile.bytes!;

        return DataSuccess(bytes);
      }

      return DataFailed(
        ErrorResponse(
          message: 'Invalid file selected',
          status: 'Failed',
          code: 600,
          data: '',
        ),
      );
    } catch (e) {
      return DataFailed(
        ErrorResponse(
          message: 'Error occurred while picking file',
          status: 'Failed',
          code: 600,
          data: '$e',
        ),
      );
    }
  }
}
