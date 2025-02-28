import 'package:dotenv/dotenv.dart';

/// Clase de configuración para cargar y acceder a variables de entorno usando
/// el paquete `dotenv`.
///
/// Esta clase proporciona métodos estáticos para cargar variables de entorno
/// desde un archivo `.env` y recuperar sus valores usando una clave dada.
class DotenvConfig {
  /// Instancia interna de [DotEnv] para gestionar variables de entorno.
  static final DotEnv _env = DotEnv();

  /// Carga variables de entorno desde un archivo `.env`.
  ///
  /// Este método debe ser llamado antes de acceder a cualquier variable de
  /// entorno usando el método [get].
  static void loadEnv() {
    _env.load();
  }

  /// Recupera el valor de una variable de entorno para una clave dada.
  ///
  /// Si la clave existe en las variables de entorno cargadas, se devuelve
  /// su valor. Si la clave no existe, se devuelve una cadena vacía.
  ///
  /// [key] La clave de la variable de entorno a recuperar.
  /// Devuelve el valor de la variable de entorno, o una cadena vacía si
  /// la clave no se encuentra.
  static String get(String key) {
    return _env[key] ?? '';
  }
}
