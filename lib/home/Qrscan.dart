import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:story_image_ai/home/second/premium_required.dart';

import '../main.dart';

class QRSCAN extends StatefulWidget {
  const QRSCAN({super.key});

  @override
  State<QRSCAN> createState() => _QRSCANState();
}

class _QRSCANState extends State<QRSCAN> {
  String? bookTitle;

  String? bookAuthor;

  String? bookThumbnail;

  Future<void> scanBarcodeAndFetchBookInfo() async {
    final scannedBarcode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );

    if (scannedBarcode != null && scannedBarcode is String) {
      // Use Google Books API to fetch book info
      await fetchBookInfo(scannedBarcode);
    }
  }

  Future<void> fetchBookInfo(String isbn) async {
    final apiKey = '';
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['items'] != null && data['items'].isNotEmpty) {
          final book = data['items'][0]['volumeInfo'];
          setState(() {
            bookTitle = book['title'];
            bookAuthor = book['authors']?.join(', ') ?? 'Unknown Author';
            bookThumbnail = book['imageLinks']?['thumbnail'];
          });
        } else {
          showError("No book found for this ISBN.");
        }
      } else {
        showError("Error fetching book data.");
      }
    } catch (e) {
      showError("Failed to fetch book information.");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('Book Scanner',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bookThumbnail != null)
              Image.network(bookThumbnail!)
            else
              Image.asset("assets/giphy.gif",width: 180,),
            const SizedBox(height: 20),
            Text(
              bookTitle ?? 'Scan a book to get details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: !isDarkModeEnabled?Colors.white:Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              bookAuthor ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InkWell(
             onTap: () async {
               final prefs = await SharedPreferences.getInstance();
               final currentTime = DateTime.now().millisecondsSinceEpoch;
               final lastResetTime = prefs.getInt('lastResetTime') ?? currentTime;
               final usageCount = prefs.getInt('usageCount') ?? 0;
               final elapsedTime = currentTime - lastResetTime;
               const resetDuration = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
               if (elapsedTime >= resetDuration) {
                 await prefs.setInt('usageCount', 0);
                 await prefs.setInt('lastResetTime', currentTime);
               }
               final updatedUsageCount = prefs.getInt('usageCount') ?? 0;

               if (updatedUsageCount < 3) {
                 scanBarcodeAndFetchBookInfo();
                 await prefs.setInt('usageCount', updatedUsageCount + 1);

               } else {
                 final timeLeft = resetDuration - elapsedTime; // Time left for reset
                 final timeLeftInSeconds = (timeLeft / 1000).ceil();
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => PremiumRequired(ed: timeLeftInSeconds),
                   ),
                 );
               }
               },
              child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width-90,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        border: Border.all(
                            color: Colors.yellowAccent,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code,color: Colors.black),
                        SizedBox(width: 8,),
                        Text(
                          "Scan Barcode",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
