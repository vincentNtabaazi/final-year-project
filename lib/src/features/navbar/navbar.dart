import 'package:flutter/material.dart';
import 'package:medbridge/src/features/Doctors/presentation/select_doctor.dart';
import 'package:medbridge/src/features/appointments/presentation/appointments_screen.dart';
import 'package:medbridge/src/features/history/presentation/history_screen.dart';
import 'package:medbridge/src/features/navbar/navbar_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int nowIndex = 0;
  void onTap(int index) {
    setState(() {
      nowIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List pages = [
      const SelectDoctors(),
      const AppointmentsScreen(),
      const HistoryScreen(),
    ];
    return Scaffold(
      body: pages[nowIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(

            // unselectedLabelStyle: theme.textTheme.displaySmall,
            // selectedLabelStyle: theme.textTheme.displaySmall,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 214, 223, 238),
            currentIndex: nowIndex,
            onTap: onTap,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Color.fromARGB(255, 8, 33, 99),
            // unselectedItemColor: theme.disabledColor,
            selectedIconTheme:
                IconThemeData(color: Color.fromARGB(255, 8, 33, 99)),
            unselectedIconTheme: IconThemeData(color: theme.disabledColor),
            items: [
              BottomNavigationBarItem(
                  label: "Therapist",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: BarIcon(
                        name: 'Doctors', active: nowIndex == 0 ? true : false),
                  )),
              BottomNavigationBarItem(
                  label: "Appointments",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: BarIcon(
                        name: 'Appointments',
                        active: nowIndex == 1 ? true : false),
                  )),
              BottomNavigationBarItem(
                  label: "History",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: BarIcon(
                        name: 'History', active: nowIndex == 2 ? true : false),
                  )),
            ]),
      ),
    );
  }
}
