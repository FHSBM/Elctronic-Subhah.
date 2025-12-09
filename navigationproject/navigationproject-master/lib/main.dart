import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assignment',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BottomNavPage(),
    );
  }
}

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  // Controllers for Home Page
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  // Pages
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      // Home Page
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstController,
              decoration: InputDecoration(labelText: "Enter text here"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: secondController,
              decoration: InputDecoration(labelText: "Result"),
              enabled: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                secondController.text = firstController.text;
              },
              child: Text("Copy Text"),
            ),
          ],
        ),
      ),

      // Search Page with ListView
      ListView.builder(
        itemCount: 10, // Example 10 items
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.list),
            title: Text("Item ${index + 1}"),
            subtitle: Text("Subtitle for item ${index + 1}"),
          );
        },
      ),

      // Settings Page
      Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: 24),
        ),
      ),

      // Account Page
      Center(
        child: Text(
          "Account Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
