import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // اجعل التطبيق شاشة كاملة (اخفاء شريط النظام)
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const SebhaApp());
}

class SebhaApp extends StatelessWidget {
  const SebhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SebhaScreen(),
    );
  }
}

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({Key? key}) : super(key: key);

  @override
  _SebhaScreenState createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int subhanCount = 0;
  int hamdCount = 0;
  int akbarCount = 0;

  void incrementSubhan() {
    if (subhanCount < 33) {
      HapticFeedback.lightImpact();
      setState(() => subhanCount++);
    }
  }

  void incrementHamd() {
    if (hamdCount < 33) {
      HapticFeedback.lightImpact();
      setState(() => hamdCount++);
    }
  }

  void incrementAkbar() {
    if (akbarCount < 34) {
      HapticFeedback.lightImpact();
      setState(() => akbarCount++);
    }
  }

  void resetAll() {
    HapticFeedback.mediumImpact();
    setState(() {
      subhanCount = 0;
      hamdCount = 0;
      akbarCount = 0;
    });
  }

  Widget buildTasbeehSection(
      String title, int count, int max, VoidCallback onPressed, List<Color> colors) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.25,
              shadows: [
                Shadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))
              ],
            ),
          ),
          const SizedBox(height: 10),

          Text(
            '$count / $max',
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(22),
              elevation: 6,
            ),
            child: Icon(Icons.touch_app, color: colors[0], size: 30),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFe8f6f3),
              Color(0xFFdff1ea),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 28),

                Text(
                  'السبحة الإلكترونية',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0f766e),
                    shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 22),

               
                buildTasbeehSection(
                  'سُبْحَانَ اللهِ',
                  subhanCount,
                  33,
                  incrementSubhan,
                  [Colors.teal, Colors.green],
                ),

                buildTasbeehSection(
                  'الْـحَـمْـدُ للهِ',
                  hamdCount,
                  33,
                  incrementHamd,
                  [Colors.indigo, Colors.blue],
                ),

                buildTasbeehSection(
                  'اللّٰـهُ أَكْبَـرْ',
                  akbarCount,
                  34,
                  incrementAkbar,
                  [Colors.deepPurple, Colors.pinkAccent],
                ),

                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: resetAll,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    'إعادة التصفير',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFd32f2f),
                    padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
