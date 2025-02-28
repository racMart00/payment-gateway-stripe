import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/payment_intents/domain/payment_intent_entity.dart';

/// Clase responsable de interactuar con la API de Stripe
///  para crear PaymentIntents.
class StripePaymentIntentRepository {
  /// Instancia de [StripeConfig] para obtener la clave secreta y realizar
  /// las peticiones.
  final StripeConfig config = StripeConfig();

  /// Crea un PaymentIntent en Stripe.
  ///
  /// Esta función hace una petición a la API de Stripe para crear un
  /// PaymentIntent usando los datos proporcionados (ID de cliente, ID de
  /// método de pago, monto y moneda).
  ///
  /// Retorna un [PaymentIntent] si la creación es exitosa, o `null` si
  /// ocurre un error.
  ///
  /// [customerId] El ID del cliente.
  /// [paymentMethodId] El ID del método de pago.
  /// [amount] El monto de la transacción (en la unidad más pequeña,
  /// e.g., centavos).
  /// [currency] La moneda en la que se realiza el pago.
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
      'return_url': 'https://your-website.com/return_url',
      // Añade la URL de retorno
    };

    final response =
        await config.httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Convertimos la respuesta JSON a un Map<String, dynamic>
      final responseData =
          json.decode(response.body) as Map<String, dynamic>;

      // Verificamos que el ID sea del tipo String
      final id = responseData['id'] as String;

      // Retornamos el PaymentIntent con el id recibido
      return PaymentIntent(id: id);
    } else {
      log('Error al crear intento de pago: ${response.body}');
      return null;
    }
  }
}
