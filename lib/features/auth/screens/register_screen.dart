import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luarsekolah_project/features/home/screens/home_screen.dart';

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
  final _emailController = TextEditingController();
  bool _isEmailValid = true;
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
  final _nameController = TextEditingController(); 
  bool _isFormValid = false; 
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _phoneController.addListener(_validatePhone);
    _emailController.addListener(_validateEmail);
    _nameController.addListener(_validateForm);
  }

  void _validateName() {
  final name = _nameController.text;
  setState(() {
    // Nama dianggap valid jika panjangnya 3 karakter atau lebih
    _isNameValid = name.length >= 3;
  });
  _validateForm(); // Panggil validasi utama
}
  
  void _validateEmail() {
  final email = _emailController.text;
  // Pola Regex untuk format email umum
  final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  setState(() {
    // Email dianggap valid jika kolomnya kosong ATAU formatnya cocok.
    // Error hanya muncul jika kolom terisi TAPI formatnya salah.
    _isEmailValid = email.isEmpty || emailRegex.hasMatch(email);
    _validateForm();
  });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _validateForm();
    });
  }

  void _validatePhone() {
    final phone = _phoneController.text;
    setState(() {
      _isPhoneFormatValid = phone.startsWith('62');
      _isPhoneLengthValid = phone.length >= 10;
      _validateForm();
    });
  }

// Validasi Form
void _validateForm() {
  // Cek semua kondisi di sini
  final allConditionsMet = 
      _isNameValid &&
      _isEmailValid && _emailController.text.isNotEmpty &&
      _isPhoneFormatValid && _isPhoneLengthValid &&
      _isLengthValid && _hasUppercase && _hasNumber && _hasSymbol &&
      _isChecked;

      // --- TAMBAHKAN KODE DEBUGGING DI SINI ---
  print('--- Validasi Form ---');
  print('Nama Terisi: ${_nameController.text.isNotEmpty}');
  print('Email Valid: $_isEmailValid');
  print('Email Terisi: ${_emailController.text.isNotEmpty}');
  print('Format Telepon Valid: $_isPhoneFormatValid');
  print('Panjang Telepon Valid: $_isPhoneLengthValid');
  print('Panjang Password Valid: $_isLengthValid');
  print('Password Punya Huruf Besar: $_hasUppercase');
  print('Password Punya Angka: $_hasNumber');
  print('Password Punya Simbol: $_hasSymbol');
  print('Checkbox Tercentang: $_isChecked');
  print('==> HASIL AKHIR (Harusnya true): $allConditionsMet');
  print('----------------------');
  // --- BATAS KODE DEBUGGING ---


  // Update state tombol jika statusnya berubah
  if (_isFormValid != allConditionsMet) {
    setState(() {
      _isFormValid = allConditionsMet;
    });
  }
}

Widget _buildNameTextField() {
  // Gunakan Column sebagai pembungkus utama, bukan Container.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Agar semua isinya rata kiri
    children: [
      // 1. Widget Label
      const Text(
        'Nama Lengkap',
        style: TextStyle(color: Color(0xFF09090B), fontSize: 14),
      ),
      // 2. Widget untuk memberi jarak
      const SizedBox(height: 4),
      // 3. Widget Input Field
      TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: 'Seperti di KTP',
          // ... sisa styling Anda ...
        ),
      ),
      // Jika ada validasi, bisa ditambahkan di sini
      // if (!_isNameValid && _nameController.text.isNotEmpty) ...
    ],
  );
}

  // Fungsi untuk membangun header
  Widget _buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1. Menampilkan Logo dari folder assets
      Image.asset(
        'assets/icon/luarsekolah_logo.png', // Pastikan path ini sesuai dengan struktur folder Anda
        height: 40, // Sesuaikan ukurannya
      ),
      const SizedBox(height: 24),

      // 2. Judul Utama
      const Text(
        'Daftarkan Akun Untuk Lanjut Akses ke Luarsekolah',
        style: TextStyle(
          color: Color(0xFF09090B),
          fontSize: 22, // Sedikit diperbesar agar mirip desain
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 12),

      // 3. Sub-judul
      const Text(
        'Satu akun untuk akses Luarsekolah dan BelajarBekerja',
        style: TextStyle(
          color: Color(0xFF7B7F95),
          fontSize: 14,
        ),
      ),
    ],
  );
  }
  
  // Fungsi untuk membangun tombol Google
  Widget _buildGoogleButton() {
  return OutlinedButton.icon(
    // Aksi yang dijalankan saat tombol ditekan
    onPressed: () {
      // TODO: Implementasi logika daftar dengan Google
      print('Tombol Google diklik!');
    },
    // Ikon/logo di sebelah kiri
    icon: Image.asset(
      'assets/icon/google_logo.png',
      height: 20.0, // Sesuaikan ukuran logo
      width: 20.0,
    ),
    // Teks di sebelah kanan ikon
    label: const Text(
      'Daftar dengan Google',
      style: TextStyle(
        color: Color(0xFF09090B),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    // Styling untuk tombol
    style: OutlinedButton.styleFrom(
      // Membuat tombol memenuhi lebar layar
      minimumSize: const Size(double.infinity, 48),
      // Styling border
      side: const BorderSide(color: Color(0xFF3F3F4B), width: 1),
      // Membuat sudut tombol melengkung
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
  }
  
  

  // Fungsi untuk membangun pemisah email
  Widget _buildEmailSeparator() {
  return Row(
    children: [
      // Garis di sebelah kiri (akan mengisi ruang kosong)
      const Expanded(
        child: Divider(
          color: Color(0xFFCBCDD6),
          thickness: 1,
        ),
      ),
      // Teks di tengah
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'atau gunakan email',
          style: TextStyle(
            color: Color(0xFF3F3F4B),
            fontSize: 12,
          ),
        ),
      ),
      // Garis di sebelah kanan (akan mengisi ruang kosong)
      const Expanded(
        child: Divider(
          color: Color(0xFFCBCDD6),
          thickness: 1,
        ),
      ),
    ],
  );
}

// Fungsi untuk membangun TextField Email dengan validasi
Widget _buildEmailTextField() {
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
          // Ubah warna border jika tidak valid
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: _isEmailValid ? const Color(0xFFA7AAB9) : Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: _isEmailValid ? Theme.of(context).primaryColor : Colors.red, width: 2),
          ),
        ),
      ),
      // Tampilkan pesan error jika tidak valid DAN tidak kosong
      if (!_isEmailValid && _emailController.text.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: const [
              Icon(Icons.error, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                'Format tidak sesuai. Contoh: user@email.com',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ),
        ),
    ],
  );
}

  // Fungsi untuk membangun footer
  Widget _buildFooter() {
  return Column(
    children: [
      // 1. Teks Syarat & Ketentuan
      Text.rich(
        TextSpan(
          style: const TextStyle(
            color: Color(0xFF7B7F95),
            fontSize: 14,
          ),
          children: [
            const TextSpan(text: 'Dengan mendaftar di Luarsekolah, kamu menyetujui '),
            TextSpan(
              text: 'syarat dan ketentuan kami',
              style: const TextStyle(
                color: Color(0xFF2570EB), // Warna biru untuk link
                decoration: TextDecoration.underline,
              ),
              // recognizer digunakan untuk membuat teks bisa diklik
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: Tambahkan aksi saat link diklik (misal: buka browser)
                  print('Link Syarat & Ketentuan diklik!');
                },
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),

      // 2. Kotak "Sudah Punya Akun?"
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF5FF), // Warna latar biru muda
          border: Border.all(color: const Color(0xFF2570EB)), // Border biru
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji lambaian tangan
            const Text('👋', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: Color(0xFF09090B),
                  fontSize: 14,
                ),
                children: [
                  const TextSpan(text: 'Sudah punya akun? '),
                  TextSpan(
                    text: 'Masuk ke akunmu',
                    style: const TextStyle(
                      color: Color(0xFF2570EB),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Tambahkan aksi navigasi ke halaman login
                        print('Link Masuk diklik!');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void _submitForm() {
  // Import home_screen.dart jika belum
  
  
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
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
                _buildHeader(),
                const SizedBox(height: 24), 
                _buildGoogleButton(),
                const SizedBox(height: 16), 
                _buildEmailSeparator(),
                const SizedBox(height: 16),
                _buildNameTextField(),
                const SizedBox(height: 16),
                _buildEmailTextField(),
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
                            _validateForm();
                        },
                      ),
                      const Text("I'm not a robot"),
                      const Spacer(),
                      // Pastikan gambar ini ada di folder assets Anda
                      Image.asset('assets/icon/recaptcha_logo.png', width: 48) 
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                // Jika _isFormValid true, jalankan _submitForm. Jika false, tombol akan nonaktif (null).
                  onPressed: _isFormValid ? _submitForm : null, 
                  style: ElevatedButton.styleFrom(
                // Warna tombol akan diatur otomatis oleh Flutter saat nonaktif
                  backgroundColor: const Color(0xFF077E60), 
                  minimumSize: const Size(double.infinity, 48),
                // Ganti warna abu-abu saat nonaktif jika Anda mau
                  disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text('Daftarkan Akun', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
          
                _buildFooter(),
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