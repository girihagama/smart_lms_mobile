import 'package:intl/intl.dart';

class BorrowedBookResult {
  String? message;
  List<BorrowedBook>? borrowedBooks;

  BorrowedBookResult({this.message, this.borrowedBooks});

  factory BorrowedBookResult.fromJson(Map<String, dynamic> json) {
    return BorrowedBookResult(
      message: json['message'],
      borrowedBooks: json['data'] != null
          ? List<BorrowedBook>.from(
              json['data'].map((book) => BorrowedBook.fromMap(book)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': borrowedBooks?.map((book) => book.toMap()).toList(),
    };
  }
}

class BorrowedBook {
  int? transactionId;
  String? transactionBookId;
  String? transactionUserEmail;
  DateTime? transactionBorrowDate;
  DateTime? transactionReturnDate;
  String? transactionStatus;
  int? transactionLateFee;
  int? transactionLateDays;
  int? transactionLatePayments;
  bool? transactionLatePaid;
  int? transactionRating;
  String? bookId;
  String? bookName;
  String? bookDescription;
  String? bookImage;
  int? bookReaders;
  int? bookRating;
  int? bookLateFee;
  String? bookCondition;
  String? bookStatus;
  DateTime? bookAddedDate;
  String? transactionReturn;

  BorrowedBook({
    this.transactionId,
    this.transactionBookId,
    this.transactionUserEmail,
    this.transactionBorrowDate,
    this.transactionReturnDate,
    this.transactionStatus,
    this.transactionLateFee,
    this.transactionLateDays,
    this.transactionLatePayments,
    this.transactionLatePaid,
    this.transactionRating,
    this.bookId,
    this.bookName,
    this.bookDescription,
    this.bookImage,
    this.bookReaders,
    this.bookRating,
    this.bookLateFee,
    this.bookCondition,
    this.bookStatus,
    this.bookAddedDate,
    this.transactionReturn,
  });

  factory BorrowedBook.fromMap(Map<String, dynamic> map) {
    return BorrowedBook(
      transactionId: map['transaction_id'],
      transactionBookId: map['transaction_book_id'],
      transactionUserEmail: map['transaction_user_email'],
      transactionBorrowDate: map['transaction_borrow_date'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['transaction_borrow_date'])
          : null,
      transactionReturnDate: map['transaction_return_date'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['transaction_return_date'])
          : null,
      transactionStatus: map['transaction_status'],
      transactionLateFee: map['transaction_late_fee'],
      transactionLateDays: map['transaction_late_days'],
      transactionLatePayments: map['transaction_late_payments'],
      transactionLatePaid: map['transaction_late_paid'] != null,
      transactionRating: map['transaction_rating'],
      bookId: map['book_id'],
      bookName: map['book_name'],
      bookDescription: map['book_description'],
      bookImage: map['book_image'],
      bookReaders: map['book_readers'],
      bookRating: map['book_rating'],
      bookLateFee: map['book_late_fee'],
      bookCondition: map['book_condition'],
      bookStatus: map['book_status'],
      bookAddedDate: map['book_added_date'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['book_added_date'])
          : null,
      transactionReturn: map['transaction_return'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transaction_id': transactionId,
      'transaction_book_id': transactionBookId,
      'transaction_user_email': transactionUserEmail,
      'transaction_borrow_date': transactionBorrowDate?.toIso8601String(),
      'transaction_return_date': transactionReturnDate?.toIso8601String(),
      'transaction_status': transactionStatus,
      'transaction_late_fee': transactionLateFee,
      'transaction_late_days': transactionLateDays,
      'transaction_late_payments': transactionLatePayments,
      'transaction_late_paid': transactionLatePaid,
      'transaction_rating': transactionRating,
      'book_id': bookId,
      'book_name': bookName,
      'book_description': bookDescription,
      'book_image': bookImage,
      'book_readers': bookReaders,
      'book_rating': bookRating,
      'book_late_fee': bookLateFee,
      'book_condition': bookCondition,
      'book_status': bookStatus,
      'book_added_date': bookAddedDate?.toIso8601String(),
      'transaction_return': transactionReturn,
    };
  }
}
