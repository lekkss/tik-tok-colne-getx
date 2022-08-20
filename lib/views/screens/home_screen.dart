import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curentPage],
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: curentPage,
        onTap: ((idx) {
          setState(() {
            curentPage = idx;
          });
        }),
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgrondColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
