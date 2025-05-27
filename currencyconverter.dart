import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController amountController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  double result = 0;
  String selectedCurrency = '';
  String message = '';

  // Example hardcoded exchange rates
  final double usdRate = 1600;
  final double eurRate = 2000;
  final double gbpRate = 1800;

  void convertCurrency() {
    double? nairaAmount = double.tryParse(amountController.text);
    String currencyInput = currencyController.text.trim().toUpperCase();

    if (nairaAmount == null || nairaAmount <= 0) {
      setState(() {
        message = 'Enter a valid amount in Naira.';
        result = 0;
      });
      return;
    }

    switch (currencyInput) {
      case 'USD':
        result = nairaAmount / usdRate;
        message = 'Converted to USD: ${result.toStringAsFixed(2)}';
        break;
      case 'EUR':
        result = nairaAmount / eurRate;
        message = 'Converted to EUR: ${result.toStringAsFixed(2)}';
        break;
      case 'GBP':
        result = nairaAmount / gbpRate;
        message = 'Converted to GBP: ${result.toStringAsFixed(2)}';
        break;
      default:
        result = 0;
        message = 'Unsupported currency. Use USD, EUR, or GBP.';
    }

    if (kDebugMode) {
      print('Result: $result $currencyInput');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: inputDecoration('Enter amount in Naira'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: currencyController,
              keyboardType: TextInputType.text,
              decoration: inputDecoration('Enter currency (USD, EUR, GBP)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: const Icon(Icons.monetization_on),
      prefixIconColor: Colors.black87,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87, width: 2.0),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87, width: 2.0),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
