import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_lms/controller/apiclient.dart';

import 'package:smart_lms/view/fine_screen.dart';
import 'package:smart_lms/view/history_screen.dart';
import 'package:smart_lms/view/landing_screen.dart';
import 'package:smart_lms/view/login.dart';
import 'package:smart_lms/view/scan_book.dart';
import 'package:smart_lms/widget/widgets.dart';

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
    FineScreen(),
    ProfileWidget()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool>checkSessionExpired() async {

    final jwt = JWT.decode(ApiClient.bearerToken);
    final Map<String,dynamic> configMap = jwt.payload;

    int exp = configMap['exp'];

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(exp*1000);

    return DateTime.now().isAfter(dateTime);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _checkAndHandleSession();
  }

void _checkAndHandleSession() async {
  bool isExpired = await checkSessionExpired();
  if (isExpired) {
    _showSessionExpiredDialog();
  }
}

void _showSessionExpiredDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text('Session Expired'),
      content: Text('Your session has expired. Please log in again.'),
      actions: [
        TextButton(
          onPressed: ()async {
            await      _logout();

            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> _logout()async {
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return LoginPage();
  }));
}




  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
 final result = await showDialog(
            context: context,
            builder: (context) => Alert(
              title: 'Are You sure',
              content: Text(
                'Do you want to Close the app?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.045),
                // style: CustomTextStyles.titleMedium2,
              ),
              actions: [
                ElevatedButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                          //fontFamily: "Century Gothic",
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    } //Navigator.pop( context, false)
                    ),
                ElevatedButton(
                    onPressed: () {
                      // SystemNavigator.pop();
                      // Navigator.pop(context, true);
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                          //fontFamily: "Century Gothic",
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          );
          if (result) {
            SystemNavigator.pop();
          }


      },
      child: Scaffold(
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
      
              icon: ImageIcon(
                AssetImage("assets/images/fine.png")
              ),
              label: 'Fine',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}