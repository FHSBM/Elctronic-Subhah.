import 'package:flutter/material.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/home_page.dart';
import 'pages/reset_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String? _username;

  void _onLoginSuccess(String username) {
    setState(() {
      _username = username;
      _currentIndex = 2; // Home
    });
  }

  void _onSignUpSuccess(String username) {
    setState(() {
      _username = username;
      _currentIndex = 2; // Home
    });
  }

  void _goToSignUp() {
    setState(() {
      _currentIndex = 1; // Sign Up tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      SignInPage(
        onLoginSuccess: _onLoginSuccess,
        onGoToSignUp: _goToSignUp,
      ),
      SignUpPage(onSignUpSuccess: _onSignUpSuccess),
      HomePage(username: _username),
      const ResetPasswordPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign System'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_reset),
            label: 'Reset',
          ),
        ],
      ),
    );
  }
}
