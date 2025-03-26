import 'package:smart_lms/view/history_screen.dart';
import 'package:smart_lms/view/scan_book.dart';
import 'package:smart_lms/widget/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

int _selectedIndex = 0;

  // List of pages for each tab
    List<Widget> _widgetOptions = <Widget>[
    BorrowedBooksWidget(),
    HistoryScreen(),
    BookScanScreen(),
    FinePaymentCard(),
    ProfileWidget()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(title: Text('Smart Library')),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.book,color: Colors.green,),
            label: 'Reading',
          ),
          BottomNavigationBarItem(
                        backgroundColor: Colors.black,

            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
                        backgroundColor: Colors.black,

            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
              BottomNavigationBarItem(
                            backgroundColor: Colors.black,

            icon: Icon(Icons.currency_bitcoin),
            label: 'Fine',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}