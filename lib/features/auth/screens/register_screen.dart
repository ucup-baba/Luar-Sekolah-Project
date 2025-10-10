import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sign_in_screen.dart'; 
import '../services/auth_service.dart'; // Sesuaikan path jika berbeda
import 'verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luar Sekolah App',
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // --- KUMPULAN STATE & CONTROLLERS ---
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isNameValid = false;
  bool _isEmailValid = true;
  bool _isPhoneFormatValid = false;
  bool _isPhoneLengthValid = false;
  bool _isPasswordVisible = false;
  bool _isLengthValid = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSymbol = false;
  bool _isChecked = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhone);
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- KUMPULAN FUNGSI LOGIKA ---
  void _validateForm() {
    final allConditionsMet = _isNameValid &&
        _isEmailValid &&
        _emailController.text.isNotEmpty &&
        _isPhoneFormatValid &&
        _isPhoneLengthValid &&
        _isLengthValid &&
        _hasUppercase &&
        _hasNumber &&
        _hasSymbol &&
        _isChecked;

    if (_isFormValid != allConditionsMet) {
      setState(() {
        _isFormValid = allConditionsMet;
      });
    }
  }

  void _validateName() {
    final name = _nameController.text;
    setState(() {
      _isNameValid = name.length >= 3;
    });
    _validateForm();
  }

  void _validateEmail() {
    final email = _emailController.text;
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    setState(() {
      _isEmailValid = email.isEmpty || emailRegex.hasMatch(email);
    });
    _validateForm();
  }

  void _validatePhone() {
    final phone = _phoneController.text;
    setState(() {
      _isPhoneFormatValid = phone.startsWith('62');
      _isPhoneLengthValid = phone.length >= 10;
    });
    _validateForm();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
    _validateForm();
  }

  void _submitForm() {
     // Buat objek User dari controller
  final newUser = User(
    name: _nameController.text,
    email: _emailController.text,
    phoneNumber: _phoneController.text, // Pastikan tambahkan phone jika perlu
    password: _passwordController.text,
  );

  // Panggil service untuk mendaftarkan pengguna
  authService.register(newUser).then((success) {
    if (success) {
      // Jika berhasil, beri notifikasi dan pindah ke halaman login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi Berhasil! Silakan Masuk.')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const VerificationScreen()),
      );
    } else {
      // Jika gagal (misal: email sudah ada di aplikasi nyata)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi Gagal.')),
      );
    }
  });
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
                _buildNameTextField(),
                const SizedBox(height: 16),
                _buildEmailTextField(),
                const SizedBox(height: 16),
                _buildPhoneTextField(),
                if (_phoneController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(children: [
                      _buildDynamicValidationRow('Dimulai dengan kode negara 62', _isPhoneFormatValid),
                      _buildDynamicValidationRow('Minimal 10 digit', _isPhoneLengthValid),
                    ]),
                  ),
                const SizedBox(height: 16),
                _buildPasswordTextField(),
                if (_passwordController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(children: [
                      _buildDynamicValidationRow('Minimal 8 karakter', _isLengthValid),
                      _buildDynamicValidationRow('Terdapat 1 huruf kapital', _hasUppercase),
                      _buildDynamicValidationRow('Terdapat 1 angka', _hasNumber),
                      _buildDynamicValidationRow('Terdapat 1 karakter simbol (!, @, dst)', _hasSymbol),
                    ]),
                  ),
                const SizedBox(height: 24),
                _buildRecaptchaCheckbox(),
                const SizedBox(height: 24),
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
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/icon/luarsekolah_logo.png', height: 40),
        const SizedBox(height: 24),
        const Text(
          'Daftarkan Akun Untuk Lanjut Akses ke Luarsekolah',
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
        'Daftar dengan Google',
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
  
  Widget _buildNameTextField() {
    bool showError = !_isNameValid && _nameController.text.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nama Lengkap', style: TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Seperti di KTP',
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
            child: Text('Nama lengkap minimal 3 karakter.', style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    bool showError = !_isEmailValid && _emailController.text.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email Aktif', style: TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'mail@gmail.com',
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(children: const [
              Icon(Icons.error, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text('Format tidak sesuai. Contoh: user@email.com', style: TextStyle(color: Colors.red, fontSize: 12)),
            ]),
          ),
      ],
    );
  }

  Widget _buildPhoneTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nomor Telepon', style: TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: '62812xxxxxx',
            hintStyle: const TextStyle(color: Color(0xFFA7AAB9)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
          ),
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
            hintText: '••••••••••',
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

  Widget _buildDynamicValidationRow(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? const Color(0xFF085D48) : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: isValid ? const Color(0xFF085D48) : Colors.red, fontSize: 14),
        ),
      ]),
    );
  }

  Widget _buildRecaptchaCheckbox() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: const Color(0xFFD6D6D6)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue ?? false;
            });
            _validateForm();
          },
        ),
        const Text("I'm not a robot"),
        const Spacer(),
        // Image.asset('assets/icon/recaptcha_logo.png', width: 48)
      ]),
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
      child: const Text('Daftarkan Akun', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(color: Color(0xFF7B7F95), fontSize: 14),
            children: [
              const TextSpan(text: 'Dengan mendaftar di Luarsekolah, kamu menyetujui '),
              TextSpan(
                text: 'syarat dan ketentuan kami',
                style: const TextStyle(color: Color(0xFF2570EB), decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF5FF),
            border: Border.all(color: const Color(0xFF2570EB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('👋', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text.rich(
              TextSpan(
                style: const TextStyle(color: Color(0xFF09090B), fontSize: 14),
                children: [
                  const TextSpan(text: 'Sudah punya akun? '),
                  TextSpan(
                    text: 'Masuk ke akunmu',
                    style: const TextStyle(color: Color(0xFF2570EB), decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}