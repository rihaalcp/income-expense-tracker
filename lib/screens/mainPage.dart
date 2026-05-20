import 'package:flutter/material.dart';
class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  final List<Widget> _screens =[];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex =index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> const AddTransaction()),
            );
          },
        backgroundColor: ,
      ),
    );
  }
}
