import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences $storage;
late final FlutterSecureStorage $secureStorage;

enum StorageKeys {
  oneUser("oneUser"),
  users("users"),
  locale("locale"),
  theme("is_dark"),
  noteBody("body"),
  notes("notes");

  const StorageKeys(this.key);

  final String key;
}
