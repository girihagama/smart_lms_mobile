import 'package:flutter/material.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:intl/intl.dart';
import 'package:smart_lms/model/book_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  BookHistoryResult? bookHistoryResult;

  Future<void> getTransactionHistory() async {
    final data = {
      "page": 1,
      "limit": 10,
    };

    final res = await ApiClient.call('transaction/history', ApiMethod.POST, data: data);

    if (res?.data != null && res?.statusCode == 200) {
      setState(() {
        bookHistoryResult = BookHistoryResult.fromJson(res?.data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Transaction History', style: TextStyle(color: Colors.white)),
      ),
      body: bookHistoryResult == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookHistoryResult!.bookHistories?.length ?? 0,
              itemBuilder: (context, index) {
                final book = bookHistoryResult!.bookHistories![index];
                return _buildHistoryCard(book);
              },
            ),
    );
  }

  Widget _buildHistoryCard(BookHistory book) {
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
                  book.bookImage  ?? 'https://pngimg.com/d/book_PNG2111.png',
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

          // Book Details
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
                const SizedBox(height: 8),
                Text(
                  '• Condition: ${book.bookCondition}\n• Late Fee: ${book.transactionLateFee}\n• Status: ${book.transactionStatus}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
