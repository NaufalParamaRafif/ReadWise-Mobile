import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 700,
          width: 320,
          child: SingleChildScrollView(
            child: Container(
              height: 670,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Nama Depan',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Nama Belakang',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Username',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Email',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'No Telp',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Kelas',
                      isDense: true,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Password',
                      isDense: true,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
