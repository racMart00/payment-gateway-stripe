import 'package:http/http.dart' as http;
import 'package:stripe_clean_architecture/core/dotenv_config.dart';

class StripeConfig {

  factory StripeConfig() {
    return _instance;
  }

  StripeConfig._internal();
  static final StripeConfig _instance = StripeConfig._internal();
  final http.Client _httpClient = http.Client();

  String get stripeSecretKey => DotenvConfig.get('STRIPE_SECRET_KEY');
  http.Client get httpClient => _httpClient;
}