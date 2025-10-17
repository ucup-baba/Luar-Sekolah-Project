import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';
import 'register_screen.dart';
import '../services/auth_service.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // --- KUMPULAN STATE & CONTROLLERS ---
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  bool _isPasswordVisible = false;

  bool _isEmailValid = true;

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateAll);
    _passwordController.addListener(_validateAll);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- FUNGSI LOGIKA YANG SUDAH AMAN ---
  void _validateAll() {
    setState(() {
      final email = _emailController.text;
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      _isEmailValid = email.isEmpty || emailRegex.hasMatch(email);

      _isFormValid = emailRegex.hasMatch(email) && _passwordController.text.isNotEmpty;
    });
  }

  void _submitForm() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await authService.login(email, password);
  

    authService.login(email, password).then((user) {
      if (user != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Gagal! Email atau Password salah.')),
        );
      }
    });
  }


  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  // --- UI UTAMA ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildGoogleButton(),
                const SizedBox(height: 24),
                _buildEmailSeparator(),
                const SizedBox(height: 24),
                _buildEmailTextField(),
                const SizedBox(height: 16),
                _buildPasswordTextField(),
                const SizedBox(height: 16),
                _buildForgotPasswordLink(),

                const SizedBox(height: 32),
                _buildSubmitButton(),
                const SizedBox(height: 24),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- KUMPULAN FUNGSI BANTUAN UNTUK UI ---

  // (Semua fungsi _build... di bawah ini sudah benar)
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,


      children: [
        Image.asset('assets/icon/luarsekolah_logo.png', height: 40),
        const SizedBox(height: 24),
        const Text(
          'Masuk ke Akunmu Untuk Lanjut Akses ke Luarsekolah',
          style: TextStyle(
            color: Color(0xFF09090B),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Satu akun untuk akses Luarsekolah dan BelajarBekerja',
          style: TextStyle(color: Color(0xFF7B7F95), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return OutlinedButton.icon(

      onPressed: () {},
      icon: Image.asset('assets/icon/google_logo.png', height: 20.0, width: 20.0),
      label: const Text(
        'Masuk dengan Google',
        style: TextStyle(color: Color(0xFF09090B), fontSize: 14, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(color: Color(0xFF3F3F4B), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildEmailSeparator() {
    return Row(children: const [
      Expanded(child: Divider(color: Color(0xFFCBCDD6), thickness: 1)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('atau gunakan email', style: TextStyle(color: Color(0xFF3F3F4B), fontSize: 12)),
      ),
      Expanded(child: Divider(color: Color(0xFFCBCDD6), thickness: 1)),
    ]);
  }

  Widget _buildEmailTextField() {
    bool showError = !_isEmailValid && _emailController.text.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Masukkan email terdaftar',
            hintStyle: const TextStyle(color: Color(0xFFA7AAB9)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: showError ? Colors.red : const Color(0xFFA7AAB9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: showError ? Colors.red : Theme.of(context).primaryColor, width: 2),
            ),
          ),
        ),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Format email tidak valid.', style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password', style: TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Masukkan password',
            hintStyle: const TextStyle(color: Color(0xFFA7AAB9)),
            suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFFA7AAB9)),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(

        onPressed: () {},
        child: const Text(
          'Lupa password',
          style: TextStyle(
            color: Color(0xFF2570EB),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }


  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isFormValid ? _submitForm : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF077E60),
        disabledBackgroundColor: Colors.grey[300],
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text('Masuk', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('👋', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text.rich(
            TextSpan(
              style: const TextStyle(color: Color(0xFF09090B), fontSize: 14),
              children: [
                const TextSpan(text: 'Belum punya akun? '),
                TextSpan(
                  text: 'Daftar Sekarang',
                  style: const TextStyle(
                      color: Color(0xFF2570EB),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = _navigateToRegister,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}