import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/pengembalian_screen.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/semua_buku.dart';

class DetailBookPengembalian extends StatelessWidget {
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
                  "assets/images/buku 4.jpg",
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(1),
                child: Center(
                  child: Text(
                    'Theories of Psychology: Fundamentals, Applications and Future Directions',
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
                    'By Cellia Higgins',
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
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PengembalianScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 142, 31),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text(
                    'Kembalikan',
                    style: TextStyle(
                        fontFamily: "Inika",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
                ),
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
