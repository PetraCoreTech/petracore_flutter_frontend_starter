String validatorUsageExampleTemplate() => '''
// This file demonstrates various ways to use the validation utilities

import 'package:flutter/material.dart';
import '../../../core/utils/validation/validation_index.dart';

/// Example form demonstrating InputFieldValidator usage
class ExampleValidationForm extends StatefulWidget {
  const ExampleValidationForm({Key? key}) : super(key: key);

  @override
  State<ExampleValidationForm> createState() => _ExampleValidationFormState();
}

class _ExampleValidationFormState extends State<ExampleValidationForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers for form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  
  // Value notifiers for reactive forms
  final _selectedCountry = ValueNotifier<String?>(null);
  final _selectedGender = ValueNotifier<String?>(null);
  
  // List selections
  List<String> _selectedHobbies = [];
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _selectedCountry.dispose();
    _selectedGender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation Examples'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Basic required field validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter your full name',
                ),
                validator: (value) => InputFieldValidator.required(value),
              ),
              
              const SizedBox(height: 16),
              
              // Email validation with TextEditingController
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'Enter your email',
                ),
                validator: (_) => InputFieldValidator.requiredEmail(_emailController),
              ),
              
              const SizedBox(height: 16),
              
              // Password validation
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password *',
                  hintText: 'Enter a strong password',
                ),
                validator: (_) => InputFieldValidator.requiredPassword(_passwordController),
              ),
              
              const SizedBox(height: 16),
              
              // Confirm password validation
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password *',
                  hintText: 'Confirm your password',
                ),
                validator: (value) => InputFieldValidator.confirmPassword(
                  _passwordController.text,
                  value,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Phone number validation with formatting
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'Enter your phone number',
                ),
                validator: (value) => InputFieldValidator.phoneNumber(value),
                onChanged: (value) {
                  // Auto-format phone number as user types
                  final formatted = value.formatPhoneNumber();
                  if (formatted != value) {
                    _phoneController.value = _phoneController.value.copyWith(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                },
              ),
              
              const SizedBox(height: 16),
              
              // Age validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Age *',
                  hintText: 'Enter your age',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => InputFieldValidator.age(value, minAge: 18),
              ),
              
              const SizedBox(height: 16),
              
              // URL validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Website (Optional)',
                  hintText: 'Enter your website URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return InputFieldValidator.url(value);
                },
              ),
              
              const SizedBox(height: 16),
              
              // ValueNotifier validation example
              ValueListenableBuilder<String?>(
                valueListenable: _selectedCountry,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    decoration: const InputDecoration(
                      labelText: 'Country *',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'US', child: Text('United States')),
                      DropdownMenuItem(value: 'CA', child: Text('Canada')),
                      DropdownMenuItem(value: 'UK', child: Text('United Kingdom')),
                    ],
                    onChanged: (newValue) => _selectedCountry.value = newValue,
                    validator: (_) => InputFieldValidator.requiredListenable(_selectedCountry),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Multiple selection validation
              FormField<List<String>>(
                initialValue: _selectedHobbies,
                validator: (value) => InputFieldValidator.multipleSelection(value),
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Hobbies *'),
                      Wrap(
                        children: [
                          'Reading', 'Sports', 'Music', 'Travel', 'Cooking'
                        ].map((hobby) {
                          return FilterChip(
                            label: Text(hobby),
                            selected: _selectedHobbies.contains(hobby),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedHobbies.add(hobby);
                                } else {
                                  _selectedHobbies.remove(hobby);
                                }
                                field.didChange(_selectedHobbies);
                              });
                            },
                          );
                        }).toList(),
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            field.errorText!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, process the data
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form is valid! Processing...'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      
                      // Example: Print formatted data
                      debugPrint('Form Data:');
                      debugPrint('Email: \${_emailController.text}');
                      debugPrint('Phone: \${_phoneController.text.formatPhoneNumber()}');
                      debugPrint('Country: \${_selectedCountry.value}');
                      debugPrint('Hobbies: \${_selectedHobbies.join(", ")}');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fix the errors above'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Additional validation examples for specific use cases
class ValidationExamples {
  
  /// Example: Custom validation with regex
  static String? validateProductCode(String? value) {
    return InputFieldValidator.custom(
      value,
      RegExp(r'^[A-Z]{2}\d{4}\$'),
      'Product code must be in format: AB1234',
    );
  }
  
  /// Example: Credit card validation
  static String? validateCreditCard(String? value) {
    return InputFieldValidator.creditCard(value);
  }
  
  /// Example: Postal code validation with country
  static String? validatePostalCode(String? value, String? countryCode) {
    return InputFieldValidator.postalCode(value, countryCode: countryCode);
  }
  
  /// Example: OTP validation
  static String? validateOTP(String? value) {
    return InputFieldValidator.otp(value, otpLength: 6);
  }
  
  /// Example: String extension usage
  static void demonstrateStringExtensions() {
    const email = 'user@example.com';
    const phone = '1234567890';
    const name = 'john doe smith';
    
    // Email validation and masking
    debugPrint('Email is valid: \${email.isValidEmail()}');
    debugPrint('Masked email: \${email.maskEmail()}');
    
    // Phone formatting and masking
    debugPrint('Formatted phone: \${phone.formatPhoneNumber()}');
    debugPrint('Masked phone: \${phone.maskPhone()}');
    
    // Name formatting
    debugPrint('Capitalized: \${name.toTitleCase()}');
    debugPrint('Initials: \${name.generateInitials()}');
    debugPrint('Pascal case: \${name.toPascalCase()}');
  }
}

/*
Usage Tips:

1. Basic String Validation:
   validator: (value) => InputFieldValidator.required(value),
   validator: (value) => InputFieldValidator.email(value),
   validator: (value) => InputFieldValidator.password(value),

2. Controller-based Validation:
   validator: (_) => InputFieldValidator.requiredEmail(controller),
   validator: (_) => InputFieldValidator.requiredPassword(controller),

3. Custom Parameters:
   validator: (value) => InputFieldValidator.text(value, minLength: 5),
   validator: (value) => InputFieldValidator.phoneNumber(value, minLength: 10),
   validator: (value) => InputFieldValidator.age(value, minAge: 21, maxAge: 65),

4. Optional Field Validation:
   validator: (value) {
     if (value == null || value.isEmpty) return null; // Allow empty
     return InputFieldValidator.url(value); // Validate if not empty
   },

5. Reactive Forms with ValueNotifier:
   validator: (_) => InputFieldValidator.requiredListenable(valueNotifier),

6. String Extensions:
   - email.isValidEmail()
   - url.isValidUrl()
   - phone.formatPhoneNumber()
   - name.toTitleCase()
   - text.truncate(max: 50)
*/
''';
