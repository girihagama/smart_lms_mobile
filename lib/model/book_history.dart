import 'package:intl/intl.dart';

class BookHistoryResult {
  final String? message;
  final List<BookHistory>? bookHistories;
  final Pagination? pagination;

  BookHistoryResult({
    this.message,
    this.bookHistories,
    this.pagination,
  });

  factory BookHistoryResult.fromJson(Map<String, dynamic> json) {
    return BookHistoryResult(
      message: json['message'],
      bookHistories: json['data'] != null
          ? List<BookHistory>.from(
              json['data'].map((book) => BookHistory.fromMap(book)))
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromMap(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': bookHistories?.map((book) => book.toMap()).toList(),
      'pagination': pagination?.toMap(),
    };
  }
}

class BookHistory {
  final int? transactionId;
  final String? transactionBookId;
  final String? transactionUserEmail;
  final DateTime? transactionBorrowDate;
  final DateTime? transactionReturnDate;
  final String? transactionStatus;
  final int? transactionLateFee;
  final int? transactionLateDays;
  final int? transactionLatePayments;
  final String? transactionLatePaid;
  final int? transactionRating;
  final String? bookId;
  final String? bookName;
  final String? bookDescription;
  final String? bookImage;
  final int? bookReaders;
  final int? bookRating;
  final int? bookLateFee;
  final String? bookCondition;
  final String? bookStatus;
  final DateTime? bookAddedDate;

  BookHistory({
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
  });

  factory BookHistory.fromMap(Map<String, dynamic> map) {
    return BookHistory(
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
      transactionLatePaid: map['transaction_late_paid'],
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
      'transaction_late_paid': transactionLatePaid == true ? [1] : [0],
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
    };
  }
}

class Pagination {
  final int? total;
  final int? limit;
  final int? page;
  final int? pages;

  Pagination({
    this.total,
    this.limit,
    this.page,
    this.pages,
  });

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      total: map['total'],
      limit: map['limit'],
      page: map['page'],
      pages: map['pages'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'limit': limit,
      'page': page,
      'pages': pages,
    };
  }
}
