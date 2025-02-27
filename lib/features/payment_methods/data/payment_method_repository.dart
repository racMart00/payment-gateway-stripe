import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/payment_methods/domain/payment_method_entity.dart';

class StripePaymentMethodRepository {
  final StripeConfig config = StripeConfig();

  Future<PaymentMethod?> createPaymentMethod(String cardToken) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_methods');

    final headers = {
      'Authorization': 'Bearer ${config.stripeSecretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {'type': 'card', 'card[token]': cardToken};

    final response =
        await config.httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PaymentMethod(id: data['id']);
    } else {
      log('Error al crear método de pago: ${response.body}');
      return null;
    }
  }
}
