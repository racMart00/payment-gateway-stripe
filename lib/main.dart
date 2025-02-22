import 'package:stripe_clean_architecture/core/dotenv_config.dart';
import 'package:stripe_clean_architecture/features/customers/data/customer_repository.dart';
import 'package:stripe_clean_architecture/features/payment_intents/data/payment_intent_repository.dart';
import 'package:stripe_clean_architecture/features/payment_intents/presentation/payment_intent_controller.dart';
import 'package:stripe_clean_architecture/features/payment_methods/data/payment_method_repository.dart';

void main() async {
  DotenvConfig.loadEnv();

  final paymentController = PaymentController(
    customerRepository: StripeCustomerRepository(),
    paymentMethodRepository: StripePaymentMethodRepository(),
    paymentIntentRepository: StripePaymentIntentRepository(),
  );

  const email = "usuario@example.com";
  const name = "Usuario Prueba";
  const cardToken = "tok_visa";
  const amount = 5000; // En centavos
  const currency = "usd";

  await paymentController.processPayment(email, name, cardToken, amount, currency);
}