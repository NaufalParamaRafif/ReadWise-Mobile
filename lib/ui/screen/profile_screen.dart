import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(100, 165, 255, 1),
                      Color.fromRGBO(238, 240, 253, 1),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/fotobuku.jpg'),
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                const SizedBox(
                    height: 50), // Adjust height to create space below avatar
                itemProfile('Name', 'Jason Statham', Icons.person),
                const SizedBox(height: 15),
                itemProfile('Phone', '088172569983', Icons.phone),
                const SizedBox(height: 15),
                itemProfile('Address', 'Jl.Kemang, Depok', Icons.location_on),
                const SizedBox(height: 15),
                itemProfile('Email', 'jasonstatham@gmail.com', Icons.mail),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
