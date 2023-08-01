import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'assets/component.dart';
import 'login/login.dart';
import 'home.dart';
import 'appointments.dart';
import 'appt_modal.dart';
import 'dental_record.dart';
import 'profile.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AppointmentPage(),
    AppointmentModel(),
    DentalRecord(),
    ProfilePage(),
  ];

  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('patient_id');
      final username = prefs.getString('username');
      final password = prefs.getString('password');

      if (userId != null && username != null && password != null) {
        // Data is available in shared preferences
        print('User ID: $userId');
        print('Username: $username');
        print('Password: $password');
      } else {
        // Data is not available in shared preferences
        print('No data found in shared preferences.');
        toPage(context, LoginPage());
      }
    } catch (e) {
      // Error handling
      print('Error while checking login status: $e');
      // Show an error message to the user or handle the error as appropriate
    }
  }

  @override
  void dispose() {
    // Cancel any ongoing animations or timers here
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void navigateToPage(int index) {
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: _pages, index: _currentIndex),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.blue[300],
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: navigateToPage,
          items: [
            BottomNavigationBarItem(
              tooltip: "Home",
              icon: _currentIndex == 0
                  ? Ink(
                      height: 40,
                      width: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.house,
                          size: 22,
                          color: Colors.blue[800],
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.house,
                      size: 22,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              tooltip: "Appointments",
              icon: _currentIndex == 1
                  ? Ink(
                      height: 40,
                      width: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 22,
                          color: Colors.blue[800],
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 22,
                    ),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              tooltip: "Appointment",
              icon: _currentIndex == 2
                  ? Ink(
                      height: 40,
                      width: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 22,
                          color: Colors.blue[800],
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.plus,
                      size: 22,
                    ),
              label: 'Add Appointment',
            ),
            BottomNavigationBarItem(
              tooltip: "Medical Record",
              icon: _currentIndex == 3
                  ? Ink(
                      height: 40,
                      width: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.fileMedical,
                          size: 22,
                          color: Colors.blue[800],
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.fileMedical,
                      size: 22,
                    ),
              label: 'Medical records',
            ),
            BottomNavigationBarItem(
              tooltip: "Profile",
              icon: _currentIndex == 4
                  ? Ink(
                      height: 40,
                      width: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.circleUser,
                          size: 22,
                          color: Colors.blue[800],
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.circleUser,
                      size: 22,
                    ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
