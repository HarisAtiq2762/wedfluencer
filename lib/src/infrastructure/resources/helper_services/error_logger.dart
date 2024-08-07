import 'package:flutter/material.dart';

void logYourError({
  String? fileName,
  String? className,
  String? functionName,
  String? functionDetails,
  String? errorString,
}) {
  String errorFullString =
      "${fileName ?? ""} ${className ?? ""} ${functionName ?? ""} ${errorString ?? ""}";
  debugPrint(errorFullString);
}
