import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/detail_book_pengembalian.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Section(
              title: 'Sedang Dipinjam',
              books: [
                Book(
                  imageUrl: 'assets/images/buku 4.jpg',
                  title: 'Theories Of Psychology',
                  author: 'Celia Higgins',
                  status: 'Sedang dipinjam',
                ),
                Book(
                  imageUrl: 'assets/images/buku 2.jpg',
                  title: 'Physiological Psychology',
                  author: 'Sherly Williams E',
                  status: 'Sedang dipinjam',
                ),
              ],
            ),
            SizedBox(height: 20),
            Section(
              title: 'Sudah Dibaca',
              books: [
                Book(
                  imageUrl: 'assets/images/buku.jpg',
                  title: 'The Psychology of Money',
                  author: 'Morgan Housel',
                  status: 'Sudah di baca',
                ),
              ],
            ),
          ],
        ),
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
            child: Image.asset(
              book.imageUrl,
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

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(book.imageUrl),
            SizedBox(height: 20),
            Text(
              book.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By ${book.author}',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20),
            Text(
              book.status,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
