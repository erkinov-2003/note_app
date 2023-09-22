import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/src/features/home_screen/controller/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences $storage;
late final FlutterSecureStorage $secureStorage;
late final Notes $notes;


enum StorageKeys {
  oneUser("oneUser"),
  users("users"),
  locale("locale"),
  theme("is_dark"),
  notes("notes");

  const StorageKeys(this.key);

  final String key;
}
