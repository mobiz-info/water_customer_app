// parser_helper.dart

import 'dart:ffi';

int? parseInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value);
  } else if (value is double) {
    return value.truncate();
  }
  return 0;
}

bool? parseBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (value is String) {
    if (value.toLowerCase() == 'true') {
      return true;
    } else if (value.toLowerCase() == 'false') {
      return false;
    }
  }
  return null;
}

String? parseString(dynamic value) {
  if (value is String) {
    return value;
  } else if (value != null) {
    return value.toString();
  }
  return null;
}

double? parseDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is String) {
    return double.tryParse(value);
  } else if (value is int) {
    return value.toDouble();
  }
  return 0.0;
}

DateTime? parseDateTime(dynamic value) {
  if (value is DateTime) {
    return value;
  } else if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}
