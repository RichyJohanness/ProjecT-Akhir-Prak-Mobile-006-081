import 'package:flutter/material.dart';
import 'package:projectakhir_tpm_123210006/login/login.dart';

const primaryColor = Color(0xff254252);
const backgroundColor = Color(0xfff2f5f8);

class AccountPage extends StatelessWidget {
  final String username;

  const AccountPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Akun',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/riki.jpg'),
            ),
            const SizedBox(height: 5),
            Text(
              'Hello, $username',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Terimakasih untuk 1 Semester Mata Kuliah Mobile. Sangat menyenangkan bukan?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.logout, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
