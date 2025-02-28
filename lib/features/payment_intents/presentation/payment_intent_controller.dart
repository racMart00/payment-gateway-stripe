import 'dart:developer';

import 'package:stripe_clean_architecture/features/customers/data/customer_repository.dart';
import 'package:stripe_clean_architecture/features/payment_intents/data/payment_intent_repository.dart';
import 'package:stripe_clean_architecture/features/payment_methods/data/payment_method_repository.dart';

/// Controlador para procesar pagos utilizando Stripe.
///
/// Esta clase orquesta la creación de clientes, métodos de pago e intentos
/// de pago utilizando los repositorios proporcionados.
class PaymentController {
  /// Crea una instancia de [PaymentController].
  ///
  /// Requiere instancias de los repositorios para clientes, métodos de pago
  /// e intentos de pago.
  PaymentController({
    required this.customerRepository,
    required this.paymentMethodRepository,
    required this.paymentIntentRepository,
  });

  /// Repositorio para la gestión de clientes en Stripe.
  final StripeCustomerRepository customerRepository;

  /// Repositorio para la gestión de métodos de pago en Stripe.
  final StripePaymentMethodRepository paymentMethodRepository;

  /// Repositorio para la gestión de intentos de pago en Stripe.
  final StripePaymentIntentRepository paymentIntentRepository;

  /// Procesa un pago utilizando la información proporcionada.
  ///
  /// Crea un cliente, un método de pago y un intento de pago en Stripe.
  /// Registra el éxito o el error del pago en la consola.
  ///
  /// [email] Correo electrónico del cliente.
  /// [name] Nombre del cliente.
  /// [cardToken] Token de la tarjeta de pago.
  /// [amount] Monto del pago.
  /// [currency] Moneda del pago.
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
