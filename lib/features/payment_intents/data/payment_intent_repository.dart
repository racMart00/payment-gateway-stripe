import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/payment_intents/domain/payment_intent_entity.dart';

class StripePaymentIntentRepository {
  final StripeConfig config = StripeConfig();

  Future<PaymentIntent?> createPaymentIntent(
    String customerId,
    String paymentMethodId,
    int amount,
    String currency,
  ) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    final headers = {
      'Authorization': 'Bearer ${config.stripeSecretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'amount': amount.toString(),
      'currency': currency,
      'customer': customerId,
      'payment_method': paymentMethodId,
      'confirm': 'true',
    };

    final response =
        await config.httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PaymentIntent(id: data['id']);
    } else {
      log('Error al crear intento de pago: ${response.body}');
      return null;
    }
  }
}
