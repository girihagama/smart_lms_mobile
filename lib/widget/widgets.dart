import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/borrowed_book.dart';
import 'package:smart_lms/model/user.dart';



class BorrowedBooksWidget extends StatefulWidget {
  const BorrowedBooksWidget({super.key});

  @override
  State<BorrowedBooksWidget> createState() => _BorrowedBooksWidgetState();
}

class _BorrowedBooksWidgetState extends State<BorrowedBooksWidget> {
  BorrowedBookResult? borrowedBookResult;

  Future<void> getBorrowedBookResult() async {
    final res = await ApiClient.call('transaction/borrowed', ApiMethod.POST);

    if (res?.data != null && res?.statusCode == 200) {
      setState(() {
        borrowedBookResult = BorrowedBookResult.fromJson(res?.data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBorrowedBookResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Borrowed Books', style: TextStyle(color: Colors.white)),
      ),
      body: borrowedBookResult == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: borrowedBookResult!.borrowedBooks?.length,
              itemBuilder: (context, index) {
                final book = borrowedBookResult!.borrowedBooks?[index];
                return _buildBookCard(book!);
              },
            ),
    );
  }

  Widget _buildBookCard(BorrowedBook book) {
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
                   book.bookImage ??'https://backend.24x7retail.com/uploads/book_image-1742146695475-746352339.jpg',
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
                    '${book.bookRating?.toStringAsFixed(1)}',
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
                // Title and Return Date
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
                        text: book.transactionReturn,
                        style: const TextStyle(
                          color: Color(0xFF80FF80),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: '\nBORROWED: ${book.transactionBorrowDate} | RETURN: ${book.transactionReturnDate}',
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

                // Book Description
                Text(
                  book.bookDescription.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 8),

                // Book Metadata
                Text(
                  '• Condition: ${book.bookCondition}\n• Late Fee: ${book.transactionLateFee}\n• Status: ${book.transactionStatus}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          // Info Icon
          Column(
            children: [
              const Icon(Icons.info, color: Colors.greenAccent),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

  

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  UserResult? userResult;

  Future<void> getUsers(String email) async {
    final data = {"email": email};

    final res = await ApiClient.call('user/info', ApiMethod.POST, data: data);

    if (res?.data != null && res?.statusCode == 200 && res?.data['action'] == true) {
      setState(() {
        userResult = UserResult.fromJson(res?.data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers('mathusanmathu24@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Smart Library',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: userResult == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      child: Text(
                        'UM',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userResult?.user?.uM_NAME ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Member since: ${_formatDate(userResult?.user?.uM_REGISTRATION_DATE)}\nMax Books Can Borrow: ${userResult?.user?.uM_MAX_BOOKS ?? 0}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoField('Name:', userResult?.user?.uM_NAME ?? 'N/A'),
                    _buildInfoField('DOB:', _formatDate(userResult?.user?.uM_DOB)),
                    _buildInfoField('Address:', userResult?.user?.uM_ADDRESS ?? 'N/A'),
                    _buildInfoField('Contact:', userResult?.user?.uM_MOBILE ?? 'N/A'),
                    _buildInfoField('Email:', userResult?.user?.uM_CODE ?? 'N/A'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'CONTACT LIBRARY',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.email, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy/MM/dd').format(date) : 'N/A';
  }
}




class FinePaymentCard extends StatelessWidget {
  const FinePaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.white, thickness: 1.0),
          const SizedBox(height: 12),

          // Fee Per Day
          _buildInfoRow('Fee Per Day :', 'Rs.450.00', isBold: true),

          const SizedBox(height: 8),

          // Days Late
          _buildInfoRow('Days Late To Return :', '2', isBold: true),

          const SizedBox(height: 12),

          // Total Payment
          _buildInfoRow(
            'TOTAL PAYMENT TO RETURN :',
            'Rs.900.00',
            isBold: true,
            color: Colors.red,
          ),
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
          style: TextStyle(
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
