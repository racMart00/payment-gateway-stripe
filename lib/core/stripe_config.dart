import 'package:http/http.dart' as http;
import 'package:stripe_clean_architecture/core/dotenv_config.dart';

/// Configuración para interactuar con la API de Stripe.
///
/// Esta clase proporciona una instancia singleton para acceder a la clave
/// secreta de Stripe y el cliente HTTP para realizar peticiones.
class StripeConfig {
  /// Constructor de fábrica para implementar el patrón singleton.
  factory StripeConfig() {
    return _instance;
  }

  /// Constructor interno privado para el patrón singleton.
  StripeConfig._internal();

  /// Instancia única de [StripeConfig].
  static final StripeConfig _instance = StripeConfig._internal();

  /// Cliente HTTP para realizar peticiones a la API de Stripe.
  final http.Client _httpClient = http.Client();

  /// Clave secreta de Stripe obtenida de las variables de entorno.
  String get stripeSecretKey => DotenvConfig.get('STRIPE_SECRET_KEY');

  /// Cliente HTTP para realizar peticiones.
  http.Client get httpClient => _httpClient;
}
