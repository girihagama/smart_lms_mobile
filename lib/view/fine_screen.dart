import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/book_history.dart';
import 'package:intl/intl.dart';

class FineScreen extends StatefulWidget {
  const FineScreen({super.key});

  @override
  State<FineScreen> createState() => _FineScreenState();
}

class _FineScreenState extends State<FineScreen> {
  BookHistoryResult? bookHistoryResult;
  bool isEmpty =true;

  @override
  void initState() {
    super.initState();
    getFineBookDetails();
  }

  Future<void> getFineBookDetails() async {
    final res = await ApiClient.call('transaction/fined', ApiMethod.POST);

    if (res?.data != null && res?.statusCode == 200) {
      setState(() {
        bookHistoryResult = BookHistoryResult.fromJson(res?.data);
      });
    }else{
      setState(() {
        isEmpty =true;
      });
      EasyLoading.showError(res?.data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fine Details', style: TextStyle(color: Colors.white)),
      ),
      body: bookHistoryResult == null
          ? const Center(child: CircularProgressIndicator()) : isEmpty ? Center(child: Text('No records founded'),)
          : ListView.builder(
              itemCount: bookHistoryResult!.bookHistories?.length ?? 0,
              itemBuilder: (context, index) {
                final book = bookHistoryResult!.bookHistories![index];
                return Column(
                  children: [
                    _buildFineCard(book),
                    FinePaymentCard(book: book),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildFineCard(BookHistory book) {
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
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.bookImage ?? 'https://pngimg.com/d/book_PNG2111.png',
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
                    '${book.bookRating?.toStringAsFixed(1) ?? "0.0"}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${book.bookName} - ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: book.transactionStatus ?? 'Unknown',
                        style: const TextStyle(
                          color: Color(0xFF80FF80),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: '\nBORROWED: ${_formatDate(book.transactionBorrowDate)} | RETURN: ${_formatDate(book.transactionReturnDate)}',
                        style: const TextStyle(
                          color: Color(0xFF80FF80),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.bookDescription ?? 'No description available.',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.info, color: Colors.greenAccent),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return DateFormat('yyyy-MM-dd').format(date);
  }
}

class FinePaymentCard extends StatelessWidget {
  final BookHistory book;

  const FinePaymentCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Divider(color: Colors.white, thickness: 1.0),
          // const SizedBox(height: 12),
          _buildInfoRow('Fee Per Day :', 'Rs.${book.bookLateFee}', isBold: true),
          const SizedBox(height: 8),
          _buildInfoRow('Days Late To Return :', '${book.transactionLateDays}', isBold: true),
          const SizedBox(height: 12),
          _buildInfoRow(
            'TOTAL PAYMENT TO RETURN :',
            'Rs.${book.transactionLateFee}',
            isBold: true,
            color: Colors.red,
          ),
                    const Divider(color: Colors.white, thickness: 1.0),

        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
