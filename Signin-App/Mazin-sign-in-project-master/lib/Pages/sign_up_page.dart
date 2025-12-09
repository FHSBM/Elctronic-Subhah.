import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final void Function(String username)? onSignUpSuccess;

  const SignUpPage({super.key, this.onSignUpSuccess});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _departmentController = TextEditingController();

  bool _loading = false;
  String? _message;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _message = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final department = _departmentController.text.trim();

    await save(username, password, department);

    setState(() {
      _loading = false;
      _message = 'تم حفظ المستخدم بنجاح';
    });

    if (widget.onSignUpSuccess != null) {
      widget.onSignUpSuccess!(username);
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
                  'Sign Up',
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
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: 'التخصص',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'أدخل التخصص' : null,
                ),
                const SizedBox(height: 12),
                if (_message != null)
                  Text(
                    _message!,
                    style: const TextStyle(color: Colors.green),
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _handleSignUp,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text('حفظ المستخدم'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
