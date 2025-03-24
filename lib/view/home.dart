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
  static  List<Widget> _widgetOptions = <Widget>[
    // Column(
    //   children: [
    //     Expanded(
    //       child: ListView.builder(
    //         itemCount: 5,
    //         itemBuilder: (context,index){
    //       return BookCard();
    //         },
          
    //       ),
    //     ),
    //   ],
    // ),
    BorrowedBooksWidget(),
    // Text('Home Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Search Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Notifications Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    // Text('Scan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    FinePaymentCard(),
    ProfileWidget()
    // Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

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