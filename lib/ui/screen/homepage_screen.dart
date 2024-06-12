import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/detail_book_screen.dart';
import 'package:ujilevel_laravel_perpus/util.dart';
import '../../services.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late Future<List<dynamic>> _bukuList;
  static String baseUrl = Util.baseUrl;

  @override
  void initState() {
    super.initState();
    _bukuList = HomePageService.fetchBukuList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: SearchBar(),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: _bukuList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(100, 165, 255, 1),
                          Color.fromRGBO(238, 240, 253, 1),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/buku 2.jpg',
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            'New Book is ambatukam right now!!!',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      'Buku yang sedang dipinjam',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/buku 2.jpg',
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Container(
                          height: 145,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('By: Sherly William E'),
                              Text(
                                'Physiological Psychology',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text('4.5'),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text('450 Halaman'),
                                    margin: EdgeInsets.only(right: 5),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text('E-Book'),
                                    margin: EdgeInsets.only(right: 5),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('Inggris'),
                                margin: EdgeInsets.only(right: 5),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deadline:'),
                            Text('69-6-9696'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      'Rekomendasi',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  GridView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3, horizontal: 10), // padding around the grid
                    itemCount:
                        snapshot.data!.length, // total number of items
                    itemBuilder: (context, index) {
                      final buku = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailBookScreen(slug: buku['slug'])));
                        },
                        child: Image.network(
                          '$baseUrl/storage/buku/${buku['image']}',
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          }),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero, // Makes the corners square
            ),
            hintText: 'Search',
            isDense: true,
          ),
        ),
      ),
    );
  }
}
