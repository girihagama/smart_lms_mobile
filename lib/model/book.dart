import 'package:intl/intl.dart';

class BookResult {
  final bool action;
  final String message;
  final List<Book> books;
  final bool available;

  BookResult({
    required this.action,
    required this.message,
    required this.books,
    required this.available,
  });

  factory BookResult.fromJson(Map<String, dynamic> json) {
    return BookResult(
      action: json['action'] ?? false,
      message: json['message'] ?? '',
      available: json['available'] ?? false,
      books: json['book'] != null
          ? List<Book>.from(json['book'].map((book) => Book.fromJson(book)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'message': message,
      'available': available,
      'book': books.map((book) => book.toJson()).toList(),
    };
  }
}

class Book {
  final String bookId;
  final String bookName;
  final String bookDescription;
  final String bookImage;
  final int bookReaders;
  final int bookRating;
  final int bookLateFee;
  final String bookCondition;
  final String bookStatus;
  final DateTime bookAddedDate;

  Book({
    required this.bookId,
    required this.bookName,
    required this.bookDescription,
    required this.bookImage,
    required this.bookReaders,
    required this.bookRating,
    required this.bookLateFee,
    required this.bookCondition,
    required this.bookStatus,
    required this.bookAddedDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['book_id'] ?? '',
      bookName: json['book_name'] ?? '',
      bookDescription: json['book_description'] ?? '',
      bookImage: json['book_image'] ?? '',
      bookReaders: json['book_readers'] ?? 0,
      bookRating: json['book_rating'] ?? 0,
      bookLateFee: json['book_late_fee'] ?? 0,
      bookCondition: json['book_condition'] ?? '',
      bookStatus: json['book_status'] ?? '',
      bookAddedDate: json['book_added_date'] != null
          ? DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['book_added_date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'book_name': bookName,
      'book_description': bookDescription,
      'book_image': bookImage,
      'book_readers': bookReaders,
      'book_rating': bookRating,
      'book_late_fee': bookLateFee,
      'book_condition': bookCondition,
      'book_status': bookStatus,
      'book_added_date': bookAddedDate.toIso8601String(),
    };
  }
} 
