import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sign_in_screen.dart';
import 'verification_screen.dart';
import '../services/auth_service.dart'; // Sesuaikan path
import 'package:provider/provider.dart';  

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isChecked = false;
  bool _isSubmitting = false;

  // Untuk validasi dinamis password
  bool _isLengthValid = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSymbol = false;

  void _validatePassword(String password) {
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || !_isChecked) return;

    setState(() => _isSubmitting = true);

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      final newUser = User(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(), // Pastikan nama field-nya sesuai
        password: _passwordController.text.trim(),
      );

// 2. Kirim satu objek tersebut ke service
      final success = await authService.register(newUser);

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: _emailController.text.trim(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pendaftaran gagal. Coba lagi.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFormFilled = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isChecked;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildGoogleButton(),
                const SizedBox(height: 24),
                _buildEmailSeparator(),
                const SizedBox(height: 24),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPhoneField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _passwordController.text.isNotEmpty
                      ? Padding(
                          key: const ValueKey('password-checklist'),
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              _buildValidationRow('Minimal 8 karakter', _isLengthValid),
                              _buildValidationRow('Ada huruf kapital', _hasUppercase),
                              _buildValidationRow('Ada angka', _hasNumber),
                              _buildValidationRow('Ada simbol (!,@,#,...)', _hasSymbol),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 24),
                _buildRecaptchaCheckbox(),
                const SizedBox(height: 24),
                _buildSubmitButton(isFormFilled),
                const SizedBox(height: 24),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(  
          'assets/icon/luarsekolah_logo.png',
          height: 40,
        ),  
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
      icon: Image.asset('assets/icon/google_logo.png', height: 20, width: 20),
      label: const Text('Daftar dengan Google'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(color: Color(0xFF3F3F4B)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildEmailSeparator() {
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFFCBCDD6))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('atau gunakan email', style: TextStyle(color: Color(0xFF3F3F4B), fontSize: 12)),
        ),
        Expanded(child: Divider(color: Color(0xFFCBCDD6))),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Nama Lengkap',
        hintText: 'Seperti di KTP',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().length < 3) {
          return 'Nama minimal 3 karakter';
        }
        return null;
      },
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email Aktif',
        hintText: 'mail@gmail.com',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email wajib diisi';
        final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
        if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';
        return null;
      },
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        labelText: 'Nomor Telepon',
        hintText: '62812xxxxxx',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Nomor telepon wajib diisi';
        if (!value.startsWith('62')) return 'Harus diawali dengan 62';
        if (value.length < 10) return 'Minimal 10 digit';
        return null;
      },
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '••••••••••',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password wajib diisi';
        if (value.length < 8) return 'Minimal 8 karakter';
        if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Harus ada huruf besar';
        if (!RegExp(r'[0-9]').hasMatch(value)) return 'Harus ada angka';
        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Harus ada simbol';
        return null;
      },
      onChanged: (val) {
        _validatePassword(val);
        setState(() {});
      },
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(isValid ? Icons.check_circle : Icons.cancel,
              color: isValid ? const Color(0xFF085D48) : Colors.red, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? const Color(0xFF085D48) : Colors.red,
              fontSize: 13,
            ),
          ),
        ],
      ),
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
      child: Row(
        
        children: [
         
          Checkbox(
            value: _isChecked,
            onChanged: (v) => setState(() => _isChecked = v ?? false),
          ),
          const Text("I'm not a robot"),
          const Spacer(),
           Image.asset(
            'assets/icon/recaptcha_logo.png',
            width: 50,
            height: 50,
          ), // image.asset

        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isFormFilled) {
    final isActive = isFormFilled && !_isSubmitting;

    return ElevatedButton(
      onPressed: isActive ? _submitForm : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF077E60),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: _isSubmitting
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Daftarkan Akun',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(color: Color(0xFF7B7F95), fontSize: 14),
            children: [
              const TextSpan(text: 'Dengan mendaftar, kamu menyetujui '),
              TextSpan(
                text: 'syarat & ketentuan kami',
                style: const TextStyle(color: Color(0xFF2570EB), decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Container(
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
                children: [
                  const TextSpan(text: 'Sudah punya akun? '),
                  TextSpan(
                    text: 'Masuk di sini',
                    style: const TextStyle(color: Color(0xFF2570EB), decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignInScreen()),
                          ),
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
