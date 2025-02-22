import '../../customers/data/customer_repository.dart';
import '../../payment_methods/data/payment_method_repository.dart';
import '../data/payment_intent_repository.dart';

class PaymentController {
  final StripeCustomerRepository customerRepository;
  final StripePaymentMethodRepository paymentMethodRepository;
  final StripePaymentIntentRepository paymentIntentRepository;

  PaymentController({
    required this.customerRepository,
    required this.paymentMethodRepository,
    required this.paymentIntentRepository,
  });

  Future<void> processPayment(String email, String name, String cardToken, int amount, String currency) async {
    final customer = await customerRepository.createCustomer(email, name);
    if (customer == null) return;

    final paymentMethod = await paymentMethodRepository.createPaymentMethod(cardToken);
    if (paymentMethod == null) return;

    final paymentIntent = await paymentIntentRepository.createPaymentIntent(
      customer.id,
      paymentMethod.id,
      amount,
      currency,
    );

    if (paymentIntent != null) {
      print("Pago exitoso: ${paymentIntent.id}");
    } else {
      print("Error en el pago.");
    }
  }
}