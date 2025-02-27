import 'dart:convert';
import 'dart:developer';

import 'package:stripe_clean_architecture/core/stripe_config.dart';
import 'package:stripe_clean_architecture/features/customers/domain/customer_entity.dart';

class StripeCustomerRepository {
  final StripeConfig config = StripeConfig();

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
      final data = json.decode(response.body);
      return Customer(id: data['id'], email: email, name: name);
    } else {
      log('Error al crear cliente: ${response.body}');
      return null;
    }
  }
}
