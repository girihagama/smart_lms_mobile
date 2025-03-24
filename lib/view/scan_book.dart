import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/book.dart';

class BookScanScreen extends StatefulWidget {
  const BookScanScreen({super.key});

  @override
  State<BookScanScreen> createState() => _BookScanScreenState();
}

class _BookScanScreenState extends State<BookScanScreen> {

BookResult? bookResult;

Future<void> getBookDetails() async {
final data = {
"book_id":"1743116187176"

};
final res = await ApiClient.call('book/check', ApiMethod.POST,
data: data
);
if(res?.data !=null && res?.statusCode ==200){
  setState(() {
    bookResult = BookResult.fromJson(res?.data);
  });
}else{
  EasyLoading.showError("Something went wrong");
}



}




  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}