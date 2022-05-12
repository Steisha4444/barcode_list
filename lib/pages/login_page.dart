import 'package:datawiz_test/pages/barcodes_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> onAuth(context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    } finally {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BarcodesPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Вхід"),
          ElevatedButton(
            onPressed: () => onAuth(context),
            child: const Text("Увійдіть за допомогою Google"),
          ),
        ],
      ),
    ));
  }
}
