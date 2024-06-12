import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/services.dart';
import 'package:ujilevel_laravel_perpus/ui/components/book_card_denda.dart';
import 'package:ujilevel_laravel_perpus/ui/components/book_card_peminjaman.dart';
import 'package:ujilevel_laravel_perpus/ui/components/book_card_pengembalian.dart';


class MenungguScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengembalian Buku'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: MenungguService.fetchMenungguData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final dataPeminjaman = snapshot.data!['antri_peminjaman'];
            final dataPengembalian = snapshot.data!['antri_pengembalian'];
            final dataDenda = snapshot.data!['denda'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Menunggu Peminjaman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    (dataPeminjaman.length ?? 0) > 0 ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataPeminjaman.length,
                      itemBuilder: (context, index) {
                        final image = dataPeminjaman[index]['image'];
                        final judul = dataPeminjaman[index]['judul'];
                        final tanggal = dataPeminjaman[index]['tanggal_pengajuan_peminjaman'];

                        return Column(
                          children: [
                            BookCardPeminjaman(image: image, judul: judul, tanggal: tanggal),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    ) : SizedBox(),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          'Menunggu Pengembalian',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    (dataPengembalian.length ?? 0) > 0 ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataPeminjaman.length,
                      itemBuilder: (context, index) {
                        final image = dataPengembalian[index]['image'];
                        final judul = dataPengembalian[index]['judul'];
                        final tanggal = dataPengembalian[index]['tanggal_pengembalian_peminjaman'];

                        return Column(
                          children: [
                            BookCardPengembalian(image: image, judul: judul, tanggal: tanggal),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    ) : SizedBox(),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          'Denda',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    (dataDenda.length ?? 0) > 0 ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataDenda.length,
                      itemBuilder: (context, index) {
                        final image = dataDenda[index]['image'];
                        final judul = dataDenda[index]['judul'];
                        final jumlah = dataDenda[index]['denda'];

                        return Column(
                          children: [
                            BookCardDenda(image: image, judul: judul, jumlah: jumlah),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    ) : SizedBox(),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}


