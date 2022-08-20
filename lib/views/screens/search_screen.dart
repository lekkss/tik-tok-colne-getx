import 'package:flutter/material.dart';

class SearchSceen extends StatelessWidget {
  const SearchSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration: const InputDecoration(
            filled: false,
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
 