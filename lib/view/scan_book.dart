import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/book.dart';

class BookScanScreen extends StatefulWidget {
  const BookScanScreen({super.key});

  @override
  State<BookScanScreen> createState() => _BookScanScreenState();
}

class _BookScanScreenState extends State<BookScanScreen> {
  BookResult? bookResult;

  Future<void> getBookDetails({required String bookId}) async {
    final data = {"book_id": bookId};
    final res = await ApiClient.call('book/check', ApiMethod.POST, data: data);

    if (res?.data != null && res?.statusCode == 200) {
      setState(() {
        bookResult = BookResult.fromJson(res?.data);
      });
    } else {
      EasyLoading.showError("Something went wrong");
    }
  }

  Future<void> _startBarcodeScan() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (barcode != '-1') {
        await getBookDetails(bookId: barcode);
      }
    } catch (e) {
      print('Error scanning barcode: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _startBarcodeScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text('Book Scanner', style: TextStyle(color: Colors.white)),
      ),
      body: bookResult == null
          ? const Center(child: CircularProgressIndicator())
          : bookResult!.books.isEmpty
              ? const Center(
                  child: Text("No book found",
                      style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  itemCount: bookResult!.books.length,
                  itemBuilder: (context, index) {
                    final book = bookResult!.books[index];
                    return _buildBookCard(book);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startBarcodeScan,
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.qr_code_scanner, color: Colors.black),
      ),
    );
  }

Future<void>  requestBook() async{
// final res = await ApiClient.call('', method)
}





  Widget _buildBookCard(Book book) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  // book.bookImage ??
                  "https://pngimg.com/d/book_PNG2111.png",
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${book.bookRating}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'READERS\n${book.bookReaders}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.bookName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.bookDescription,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Condition: ${book.bookCondition}\n• Late Fee: ${book.bookLateFee}\n• Status: ${book.bookStatus}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child:GestureDetector(
                    
                    onTap: (){

                    },
                     child:Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white
                    ),
                    width: 100,
                    height: 30,
                    child: Center(child: Text('Request Book', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  )
                  )
                  
                  //  TextButton(
                  //   child: Text('Request book'),
                  //   onPressed: () {},
                  // ),
                ),
              ],
            ),
          ),

          // Info Icon
          const Icon(Icons.info, color: Colors.greenAccent),
        ],
      ),
    );
  }
}
