/// Represents a Stripe customer.
///
/// This class encapsulates the data of a customer created in Stripe,
/// including their unique ID, email address, and name.
class Customer {
  /// Creates a [Customer] instance.
  ///
  /// All parameters are required and represent the customer's information.
  ///
  /// [id] The unique identifier of the customer.
  /// [email] The email address of the customer.
  /// [name] The name of the customer.
  Customer({required this.id, required this.email, required this.name});

  /// The unique identifier of the customer.
  final String id;

  /// The email address of the customer.
  final String email;

  /// The name of the customer.
  final String name;
}
