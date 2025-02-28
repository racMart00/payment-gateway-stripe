import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/payment_methods/domain/payment_method_entity.dart';

/// Clase responsable de interactuar con la API de Stripe para crear métodos
/// de pago.
class StripePaymentMethodRepository {
  /// Instancia de [StripeConfig] para obtener la clave secreta y realizar
  /// las peticiones.
  final StripeConfig config = StripeConfig();

  /// Crea un método de pago en Stripe usando un token de tarjeta.
  ///
  /// Esta función hace una petición a la API de Stripe para crear un
  /// método de pago utilizando un token de tarjeta proporcionado.
  ///
  /// Retorna un [PaymentMethod] si la creación es exitosa, o `null` si
  /// ocurre un error.
  ///
  /// [cardToken] El token de la tarjeta generado por Stripe.js.
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
      // Convertimos la respuesta JSON a un Map<String, dynamic>
      final data = json.decode(response.body) as Map<String, dynamic>;

      // Verificamos que el ID sea del tipo String y lo retornamos
      final id = data['id'] as String;
      return PaymentMethod(id: id);
    } else {
      log('Error al crear método de pago: ${response.body}');
      return null;
    }
  }
}
