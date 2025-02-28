/// Represents a payment method stored in Stripe.
///
/// This class encapsulates the data of a payment method, primarily
/// its unique identifier.
class PaymentMethod {
  /// Creates a [PaymentMethod] instance.
  ///
  /// Requires the unique identifier of the payment method.
  ///
  /// [id] The unique identifier of the payment method.
  PaymentMethod({required this.id});

  /// The unique identifier of the payment method.
  final String id;
}
