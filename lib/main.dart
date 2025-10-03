
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // FIX 1: Hapus 'as Widget' yang tidak perlu.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // FIX 2: Modernisasi constructor (super.key lebih direkomendasikan).
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}

// --- FIX 3: INI ADALAH STRUKTUR YANG BENAR ---
// StatefulWidget didefinisikan SEBELUM State-nya.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Semua state dan controller Anda sudah benar di sini.
  bool _isChecked = false;
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLengthValid = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSymbol = false;
  final _phoneController = TextEditingController();
  bool _isPhoneFormatValid = false;
  bool _isPhoneLengthValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _phoneController.addListener(_validatePhone);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _validatePhone() {
    final phone = _phoneController.text;
    setState(() {
      _isPhoneFormatValid = phone.startsWith('62');
      _isPhoneLengthValid = phone.length >= 10;
    });
  }

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
                // (Isi konten UI Anda sudah benar)
                _buildTextField(label: 'Nama Lengkap', hint: 'Seperti di KTP'),
                const SizedBox(height: 16),
                _buildTextField(label: 'Email Aktif', hint: 'mail@gmail.com'),
                const SizedBox(height: 16),
                _buildPhoneTextField(),
                if (_phoneController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        _buildDynamicValidationRow('Dimulai dengan kode negara 62', _isPhoneFormatValid),
                        _buildDynamicValidationRow('Minimal 10 digit', _isPhoneLengthValid),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                _buildPasswordTextField(),
                if (_passwordController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        _buildDynamicValidationRow('Minimal 8 karakter', _isLengthValid),
                        _buildDynamicValidationRow('Terdapat 1 huruf kapital', _hasUppercase),
                        _buildDynamicValidationRow('Terdapat 1 angka', _hasNumber),
                        _buildDynamicValidationRow('Terdapat 1 karakter simbol (!, @, dst)', _hasSymbol),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      border: Border.all(color: const Color(0xFFD6D6D6)),
                      borderRadius: BorderRadius.circular(2)),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue ?? false;
                          });
                        },
                      ),
                      const Text("I'm not a robot"),
                      const Spacer(),
                      // Pastikan gambar ini ada di folder assets Anda
                      // Image.asset('assets/recaptcha_logo.png', width: 48) 
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF077E60),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Daftarkan Akun'),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- SEMUA FUNGSI HELPER ANDA SUDAH BENAR ---
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
          style: TextStyle(
            color: isValid ? const Color(0xFF085D48) : Colors.red,
            fontSize: 14,
          ),
        ),
      ]),
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

  Widget _buildTextField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF09090B), fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFA7AAB9)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFA7AAB9))),
          ),
        ),
      ],
    );
  }
}

// FIX 4: Hapus duplikat class RegisterScreen yang kosong dari bagian bawah file ini.