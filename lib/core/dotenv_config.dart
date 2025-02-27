import 'package:dotenv/dotenv.dart';

class DotenvConfig {
  static final DotEnv _env = DotEnv();

  static void loadEnv() {
    _env.load();
  }

  static String get(String key) {
    return _env[key] ?? '';
  }
}
