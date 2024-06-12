import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../util.dart';
import 'detail_book_pengembalian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatelessWidget {
  static String baseUrl = Util.baseUrl;

  Future<Map<String, dynamic>> fetchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/history'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(token.toString());
      print(response.statusCode);
      throw Exception('Failed to load history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          final sedangDipinjam = (data['sedang_dipinjam'] as List)
              .map((item) => Book.fromJson(item))
              .toList();
          final sudahDipinjam = (data['sudah_dipinjam'] as List)
              .map((item) => Book.fromJson(item))
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Section(
                  title: 'Sedang Dipinjam',
                  books: sedangDipinjam,
                ),
                SizedBox(height: 20),
                Section(
                  title: 'Sudah Dibaca',
                  books: sudahDipinjam,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Book> books;

  Section({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.clip,
        ),
        SizedBox(height: 10),
        Column(
          children: books.map((book) => BookItem(book: book)).toList(),
        ),
      ],
    );
  }
}

class Book {
  final String imageUrl;
  final String title;
  final String author;
  final String status;

  Book({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.status,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      imageUrl: json['image'],
      title: json['judul'],
      author: 'osas',
      status: 'kjj',
    );
  }
}

class BookItem extends StatelessWidget {
  final Book book;

  BookItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBookPengembalian(),
                ),
              );
            },
            child: Image.network(
              '${Util.baseUrl}/storage/buku/${book.imageUrl}',
              height: 100,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
              ),
              Text(
                'By ${book.author}',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                book.status,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
