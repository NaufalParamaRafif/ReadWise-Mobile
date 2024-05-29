import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark
//   ));
//   runApp(const MyApp());
// }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/fotobuku.jpg'),
            ),
            const SizedBox(height: 20),
            // itemProfile('Name', 'Jason Statham', CupertinoIcons.person),
            itemProfile('Name', 'Jason Statham', Icons.person),
            const SizedBox(height: 10),
            // itemProfile('Phone', '088172569983', CupertinoIcons.phone),
            itemProfile('Phone', '088172569983', Icons.phone),
            const SizedBox(height: 10),
            // itemProfile('Address', 'Jl.Kemang, Depok', CupertinoIcons.location),
            itemProfile('Address', 'Jl.Kemang, Depok', Icons.location_on),
            const SizedBox(height: 10),
            // itemProfile('Email', 'jasonstatham@gmail.com', CupertinoIcons.mail),
            itemProfile('Email', 'jasonstatham@gmail.com', Icons.mail),
            const SizedBox(
              height: 20,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.all(15),
            //     ),
            //     child: const Text('Edit Profile'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.blue.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        // trailing: Icon(
        //   Icons.arrow_forward,
        //   color: Colors.grey.shade400,
        // ),
        tileColor: Colors.white,
      ),
    );
  }
}
