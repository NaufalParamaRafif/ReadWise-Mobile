import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/semua_buku.dart';

class DetailBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/buku.jpg",
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(1),
                child: Center(
                  child: Text(
                    'The Psychology of Money: Timeless Lessons on Wealth, Greed, and Happiness',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Inika",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 1),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SemuaBukuBerdasarkan()));
                  },
                  child: Text(
                    'By Morgan Housel',
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    label: 'Rating',
                    value: '4.5/5',
                    fontFamily: "Inika",
                    fontWeight: FontWeight.w200,
                    icon: Icons.star,
                    iconColor: Colors.yellow,
                  ),
                  InfoCard(
                    label: 'Halaman',
                    value: '420',
                    fontFamily: "Inika",
                    fontWeight: FontWeight.w200,
                  ),
                  InfoCard(
                    label: 'Bahasa',
                    value: 'Indonesia',
                    fontFamily: "Inika",
                    fontWeight: FontWeight.w200,
                  ),
                  InfoCard(
                    label: 'Tipe',
                    value: 'Cetak',
                    fontFamily: "Inika",
                    fontWeight: FontWeight.w200,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Synopsis',
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Upaya seorang wanita muda dan istrinya untuk memiliki anak terungkap dalam kisah puitis yang surut dan mengalir seperti laut.\n\nSetelah bertahun-tahun kesulitan mencoba memiliki anak, pasangan muda akhirnya mengumumkan kehamilan mereka, hanya untuk memiliki hari yang paling menggembirakan dalam hidup mereka digantikan dengan salah satu patah hati yang tak terduga. Hubungan mereka diuji saat mereka terus maju, bekerja sama untuk menemukan kembali diri mereka di tengah-tengah keributan kehilangan yang menghancurkan, dan akhirnya menghadapi realitas yang menghancurkan jiwa.',
                style: TextStyle(fontFamily: "Inter", fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Penerbit : Mentari Timur Jaya',
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                'ISBN : 696969696969',
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal Publish : 6-9-2069',
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String fontFamily;
  final FontWeight fontWeight;
  final IconData? icon;
  final Color? iconColor;

  InfoCard({
    required this.label,
    required this.value,
    required this.fontFamily,
    required this.fontWeight,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: fontWeight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                SizedBox(width: 4), // Add space between icon and text
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    fontWeight: fontWeight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
