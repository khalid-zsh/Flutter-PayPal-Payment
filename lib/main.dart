import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PayPal Payment',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent
        ),
        primarySwatch: Colors.blue,
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? transactionId;
  bool isLoading = false;


  final String serverUrl = 'http://127.0.0.1:5000';


  Future<String> getClientToken() async {
    final response = await http.get(Uri.parse('$serverUrl/client_token'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['client_token'];
    } else {
      throw Exception('Failed to load client token');
    }
  }


  Future<void> startPayPalPayment(double amount) async {
    setState(() {
      isLoading = true;
    });

    try {
      String clientToken = await getClientToken();
      print("Client Token: $clientToken");

      final request = BraintreePayPalRequest(
        amount: amount.toString(),
        currencyCode: 'USD',
      );


      final result = await Braintree.requestPaypalNonce(clientToken, request);

      if (result != null) {
        String paymentMethodNonce = result.nonce;


        final response = await http.post(
          Uri.parse('$serverUrl/checkout'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'payment_method_nonce': paymentMethodNonce,
            'amount': amount.toString(),
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            setState(() {
              transactionId = data['transaction_id'];
            });
            showAlertDialog('Payment Success', 'Transaction ID: $transactionId');
          } else {
            showAlertDialog('Payment Failed', data['message']);
          }
        } else {
          showAlertDialog('Error', 'Server Error: ${response.statusCode}');
        }
      } else {
        showAlertDialog('Payment Cancelled', 'User canceled the payment');
      }
    } catch (e) {
      showAlertDialog('Error', 'Something went wrong: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  void showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with PayPal'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await startPayPalPayment(10.0); // Pay $10
              },
              child: const Text('Pay with PayPal'),
            ),
            if (transactionId != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Transaction ID: $transactionId'),
              ),
          ],
        ),
      ),
    );
  }
}

