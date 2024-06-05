import 'package:flutter/material.dart';

class SemuaBukuBerdasarkan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'By Morgan Housel',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true, // You won't see infinite size error
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 20, // spacing between rows
                crossAxisSpacing: 20, // spacing between columns
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10), // padding around the grid
              itemCount: 5, // total number of items
              itemBuilder: (context, index) {
                return InkWell(
                  child: Image.asset(
                    'assets/images/buku 2.jpg',
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
