import 'package:http/http.dart' as http;
import 'package:stripe_clean_architecture/core/dotenv_config.dart';

class StripeConfig {
  static final StripeConfig _instance = StripeConfig._internal();
  final http.Client _httpClient = http.Client();

  factory StripeConfig() {
    return _instance;
  }

  StripeConfig._internal();

  String get stripeSecretKey => DotenvConfig.get('STRIPE_SECRET_KEY');
  http.Client get httpClient => _httpClient;
}