import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/fcm.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class MockPaymentScreen extends StatefulWidget {
  const MockPaymentScreen({super.key});

  @override
  State<MockPaymentScreen> createState() => _MockPaymentScreenState();
}

class _MockPaymentScreenState extends State<MockPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  void _pay() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      if (mounted) {
        await getIt<CartCubit>().clearCart();
        await getIt<PushNotificationService>().showPaymentSuccessNotification();
        context.pushNamedAndRemoveUntil(Routes.mainlayoutPage, (route) => false, predicate: (Route<dynamic> route) => false);
      }
    }
  }

  void _onExpiryChanged(String value) {
    String cleaned = value.replaceAll('/', '');

    // ✅ max 4 digits
    if (cleaned.length > 4) cleaned = cleaned.substring(0, 4);

    // ✅ restrict first digit of month to 0 or 1
    if (cleaned.length >= 1) {
      final firstDigit = int.tryParse(cleaned[0]);
      if (firstDigit != null && firstDigit > 1) {
        cleaned = '0${cleaned.substring(0, 1)}';
      }
    }

    // ✅ restrict month max 12
    if (cleaned.length >= 2) {
      final month = int.tryParse(cleaned.substring(0, 2));
      if (month != null && month > 12) {
        cleaned = '12${cleaned.substring(2)}';
      }
    }

    // ✅ restrict year to not be less than current year
    if (cleaned.length == 4) {
      final year = int.tryParse(cleaned.substring(2, 4));
      final currentYear = DateTime.now().year % 100;
      if (year != null && year < currentYear) {
        cleaned = '${cleaned.substring(0, 2)}${currentYear.toString().padLeft(2, '0')}';
      }
    }

    // ✅ add slash
    String formatted = cleaned;
    if (cleaned.length >= 3) {
      formatted = '${cleaned.substring(0, 2)}/${cleaned.substring(2)}';
    }

    if (formatted != _expiryController.text) {
      _expiryController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {});
  }

  String? _validateExpiry(String? value) {
    if (value == null || value.isEmpty) return 'Enter expiry date';
    if (value.length < 5) return 'Enter valid expiry';

    final parts = value.split('/');
    if (parts.length != 2) return 'Enter valid expiry';

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return 'Enter valid expiry';
    if (month < 1 || month > 12) return 'Invalid month (01-12)'; // ✅
    if (parts[1].length < 2) return 'Enter valid year'; // ✅ must be 2 digits

    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (year < currentYear) return 'Card expired'; // ✅
    if (year == currentYear && month <= currentMonth) return 'Card expired'; // ✅

    return null;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment'.tr()), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // mock card visual
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.credit_card, color: Colors.white, size: 40),
                    Text(_cardNumberController.text.isEmpty ? '**** **** **** ****' : _cardNumberController.text, style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_nameController.text.isEmpty ? 'CARD HOLDER' : _nameController.text.toUpperCase(), style: const TextStyle(color: Colors.white)),
                        Text(_expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // card number
              _buildField(
                controller: _cardNumberController,
                label: 'Card Number',
                hint: '1234 5678 9012 3456',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
                validator: (value) => value!.length < 16 ? 'Enter valid card number' : null,
              ),

              const SizedBox(height: 16),

              // name
              _buildField(controller: _nameController, label: 'Name on Card', hint: 'John Doe', validator: (value) => value!.isEmpty ? 'Enter name on card' : null),

              const SizedBox(height: 16),

              Row(
                children: [
                  // expiry
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                      onChanged: _onExpiryChanged,
                      validator: _validateExpiry,
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // cvv
                  Expanded(
                    child: _buildField(
                      controller: _cvvController,
                      label: 'CVV',
                      hint: '123',
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                      validator: (value) => value!.length < 3 ? 'Enter valid CVV' : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // pay button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _isLoading ? null : _pay,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Pay Now',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
      validator: validator,
    );
  }
}
