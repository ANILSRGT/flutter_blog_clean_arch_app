import 'package:flutter/material.dart';

/// Response model
@immutable
sealed class ResponseModel<T> {
  /// Response model constructor
  const ResponseModel();

  /// Returns true if the response is success
  /// otherwise false
  bool get isSuccess => this is ResponseModelSuccess<T>;

  /// Returns true if the response is fail
  /// otherwise false
  bool get isFail => this is ResponseModelFail<T>;

  /// cast to [ResponseModelSuccess]
  ResponseModelSuccess<T> get asSuccess => this as ResponseModelSuccess<T>;

  /// cast to [ResponseModelFail]
  ResponseModelFail<T> get asFail => this as ResponseModelFail<T>;
}

/// Response model success (positive)
class ResponseModelSuccess<T> extends ResponseModel<T> {
  /// Response model success (positive) constructor
  const ResponseModelSuccess({
    required this.data,
  });

  /// Data for success (positive) response
  final T data;
}

/// Response model fail
class ResponseModelFail<T> extends ResponseModel<T> {
  /// Response model fail constructor
  const ResponseModelFail({
    required this.message,
    required this.throwMessage,
    required this.code,
  });

  /// Error code
  final String code;

  /// Error message for throw (developer message)
  final String throwMessage;

  /// Message for fail response
  final String message;
}

/// Extension for [ResponseModelFail]
extension ResponseModelFailExtension<T> on ResponseModelFail<T> {
  /// cast to [ResponseModelFail]
  /// <br/>Example: `response.asFail.castTo<YourType>()`
  ResponseModelFail<X> convertTo<X>() => ResponseModelFail<X>(
        code: code,
        message: message,
        throwMessage: throwMessage,
      );
}

/// Extension for [ResponseModelSuccess]
extension ResponseModelSuccessExtension<T> on ResponseModelSuccess<T> {
  /// cast to [ResponseModelSuccess]
  /// <br/>Example: `response.asSuccess.castTo<YourType>()`
  ResponseModelSuccess<X> convertTo<X>() => ResponseModelSuccess<X>(
        data: data as X,
      );
}
