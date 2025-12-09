import 'package:flutter/material.dart';

void main() => runApp(const MyElegantApp());

class MyElegantApp extends StatelessWidget {
  const MyElegantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elegant Tasks',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAF4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B5E3C),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          elevation: 6,
          shadowColor: Colors.black26,
        ),
      ),
      home: const TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<bool> _isDone = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مهامي اليومية'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.mosque_rounded, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTaskItem(
              index: 0,
              title: 'قراءة القرآن الكريم',
              icon: Icons.menu_book_rounded,
              color: const Color(0xFFD4AF37),
            ),
            const SizedBox(height: 14),
            _buildTaskItem(
              index: 1,
              title: 'أذكار الصباح والمساء',
              icon: Icons.wb_sunny_rounded,
              color: const Color(0xFF6D9773),
            ),
            const SizedBox(height: 14),
            _buildTaskItem(
              index: 2,
              title: 'الصلاة على النبي ﷺ',
              icon: Icons.favorite_rounded,
              color: const Color(0xFFAD8B73),
            ),
            const SizedBox(height: 14),
            _buildTaskItem(
              index: 3,
              title: 'الاستغفار والتسبيح',
              icon: Icons.star_rounded,
              color: const Color(0xFFB68973),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem({
    required int index,
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final done = _isDone[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          _isDone[index] = !_isDone[index];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: done ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: done ? color : color.withOpacity(0.5),
            width: 1.3,
          ),
        ),
        child: ListTile(
          leading: Icon(icon, color: color, size: 34),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: done ? color : Colors.grey.shade800,
              fontWeight: FontWeight.w600,
              decoration: done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Icon(
            done ? Icons.check_circle_rounded : Icons.circle_outlined,
            color: done ? color : Colors.grey.shade400,
            size: 32,
          ),
        ),
      ),
    );
  }
}
