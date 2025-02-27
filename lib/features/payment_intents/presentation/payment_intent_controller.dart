import 'dart:developer';

import 'package:stripe_clean_architecture/features/customers/data/customer_repository.dart';
import 'package:stripe_clean_architecture/features/payment_intents/data/payment_intent_repository.dart';
import 'package:stripe_clean_architecture/features/payment_methods/data/payment_method_repository.dart';

class PaymentController {
  PaymentController({
    required this.customerRepository,
    required this.paymentMethodRepository,
    required this.paymentIntentRepository,
  });
  final StripeCustomerRepository customerRepository;
  final StripePaymentMethodRepository paymentMethodRepository;
  final StripePaymentIntentRepository paymentIntentRepository;

  Future<void> processPayment(
    String email,
    String name,
    String cardToken,
    int amount,
    String currency,
  ) async {
    final customer = await customerRepository.createCustomer(email, name);
    if (customer == null) return;

    final paymentMethod =
        await paymentMethodRepository.createPaymentMethod(cardToken);
    if (paymentMethod == null) return;

    final paymentIntent = await paymentIntentRepository.createPaymentIntent(
      customer.id,
      paymentMethod.id,
      amount,
      currency,
    );

    if (paymentIntent != null) {
      log('Pago exitoso: ${paymentIntent.id}');
    } else {
      log('Error en el pago.');
    }
  }
}
