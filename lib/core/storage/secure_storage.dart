import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Write the key,value pair
void writeToStorage(key, value) async {
  try {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/// Read the key

Future<String?> readFromStorage(key) async {
  try {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}

/// Delete the key
void deleteFromStorage(key) async {
  try {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
