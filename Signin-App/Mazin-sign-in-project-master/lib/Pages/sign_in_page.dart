import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  final void Function(String username)? onLoginSuccess;
  final VoidCallback? onGoToSignUp;

  const SignInPage({super.key, this.onLoginSuccess, this.onGoToSignUp});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final ok = await checkValue(username, password);

    setState(() {
      _loading = false;
    });

    if (ok) {
      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess!(username);
      }
    } else {
      setState(() {
        _error = 'الاسم أو كلمة المرور غير صحيحة أو لا يوجد مستخدم مسجل';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'أدخل الاسم' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'أدخل كلمة المرور' : null,
                ),
                const SizedBox(height: 12),
                if (_error != null)
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _handleSignIn,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text('دخول'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    if (widget.onGoToSignUp != null) {
                      widget.onGoToSignUp!();
                    }
                  },
                  child: const Text('ما عندك حساب؟ سجّل مستخدم جديد من هنا'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
