import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences $storage;
late final FlutterSecureStorage $secureStorage;

enum StorageKeys {
  locale("locale"),
  theme("is_dark");

  const StorageKeys(this.key);

  final String key;
}
