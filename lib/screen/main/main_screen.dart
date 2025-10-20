import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/navbar/index_nav_bar.dart';
import 'package:restaurant_app/screen/home/home_page.dart';

import '../search/search_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavBar>(
        builder: (context, value, child) {
          return switch(value.index){
            0 => HomePage(),
            1 => SearchPage(),
            _ => const Center(
                child: Text("Error")
            )
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavBar>().index,
        onTap: (value) {
          context.read<IndexNavBar>().index = value;

        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search"
          )
        ]
      ),
    );
  }
}
