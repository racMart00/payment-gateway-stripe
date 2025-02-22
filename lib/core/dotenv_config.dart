import 'package:dotenv/dotenv.dart';


class DotenvConfig {
  static void loadEnv() {
    DotEnv().load();
  }

  static String get(String key) {
    return DotEnv().env[key] ?? '';
  }
}