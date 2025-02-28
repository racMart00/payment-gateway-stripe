import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/customers/domain/customer_entity.dart';

/// Clase responsable de interactuar con la API de Stripe para crear clientes.
class StripeCustomerRepository {
  /// Utiliza el [StripeConfig] para obtener la clave secreta y realizar
  /// las peticiones a la API de Stripe.
  final StripeConfig config = StripeConfig();

  /// Crea un cliente en Stripe.
  ///
  /// Esta función hace una petición a la API de Stripe para crear un
  /// cliente usando el correo electrónico y nombre proporcionados.
  ///
  /// Retorna un [Customer] si la creación es exitosa, o `null` si
  /// ocurre un error.
  ///
  /// [email] El correo electrónico del cliente.
  /// [name] El nombre del cliente.
  Future<Customer?> createCustomer(String email, String name) async {
    final url = Uri.parse('https://api.stripe.com/v1/customers');

    final headers = {
      'Authorization': 'Bearer ${config.stripeSecretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {'email': email, 'name': name};

    final response =
        await config.httpClient.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Convertimos la respuesta JSON a un Map<String, dynamic>.
      final data = json.decode(response.body) as Map<String, dynamic>;

      // Accedemos a las propiedades del Map con cast explícito.
      final customerId = data['id'] as String;
      return Customer(id: customerId, email: email, name: name);
    } else {
      log('Error al crear cliente: ${response.body}');
      return null;
    }
  }
}
