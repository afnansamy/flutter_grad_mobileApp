import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
/// This is the stateful widget that the main application instantiates.
class NavBar extends StatefulWidget {
  //const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
int _selectedIndex=2 ;
/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<NavBar> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 14);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: profile',
      style: optionStyle,
    ),
    Text(
      'Index 1: Scan QR',
      style: optionStyle,
    ),
    Text(
      'Index 2: Home',
      style: optionStyle,
    ),
    Text(
      'Index 3: Notifications',
      style: optionStyle,
    ),
    Text(
      'Index 4: Wallet',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if(_selectedIndex ==0)
          //currentIndex: _selectedIndex;
       // _selectedIndex=0;
        Navigator.of(context).pushNamed('/profile');
      if(_selectedIndex ==1)
        //scanQRCode();
      // Navigator.of(context).pushNamed('/home');
        Navigator.of(context).pushNamed('/scanqr');
      if(_selectedIndex ==2)
        // currentIndex: _selectedIndex;
        Navigator.of(context).pushNamed('/home');
      if(_selectedIndex ==3)
        //currentIndex: _selectedIndex;
        Navigator.of(context).pushNamed('/notification');
      if(_selectedIndex ==4)
        // currentIndex: _selectedIndex;
        Navigator.of(context).pushNamed('/mywallet');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: Color(0xFF1E212D)
          ),
          label: 'Profile',

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code,
             color: Color(0xFF1E212D)
          ),
          label: 'Scan QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: Color(0xFF1E212D)
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications,
              color: Color(0xFF1E212D)
          ),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_sharp,
              color: Color(0xFF1E212D)
          ),
          label: 'Wallet',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF1E212D),
      onTap: _onItemTapped,

    );
  }
}
