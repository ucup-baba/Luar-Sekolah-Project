// 1. Model untuk data pengguna
class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? address;
  final String? gender;
  final DateTime? birthDate;
  final String? jobStatus;
  final String? photoPath;
  

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.address,
    this.gender,
    this.birthDate,
    this.jobStatus,
    this.photoPath,
  });

  // ✅ PERBAIKAN 1: Method copyWith dipindahkan ke DALAM class User
  // dan menggunakan named parameter (lebih baik)
  User copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    String? gender,
    DateTime? birthDate,
    String? jobStatus,
    String? photoPath,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      jobStatus: jobStatus ?? this.jobStatus,
      photoPath: photoPath ?? this.photoPath,
    );
  }
} // <-- Class User berakhir di sini

// 2. Service untuk mengelola autentikasi
class AuthService {
  User? _registeredUser;
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  Future<bool> register(User newUser) async {
    _registeredUser = newUser;
    return true;
  }

  Future<User?> login(String email, String password) async {
    print('Mencoba login dengan email: $email');
    if (_registeredUser != null &&
        _registeredUser!.email == email &&
        _registeredUser!.password == password) {
      print('Login berhasil untuk: ${_registeredUser!.name}');
      _loggedInUser = _registeredUser;
      return _loggedInUser;
    }
    print('Login gagal: email atau password salah.');
    return null;
  }

  Future<void> updateUser(User updatedUser) async {
    if (_registeredUser != null) {
      _registeredUser = updatedUser;
      _loggedInUser = updatedUser;
      print('Data pengguna diperbarui: ${_registeredUser!.name}');
    }
  } // <-- ✅ PERBAIKAN 2: Tambahkan kurung kurawal penutup di sini

  void logout() {
    _loggedInUser = null;
  }
} // <-- Class AuthService berakhir di sini

// Singleton Pattern
final authService = AuthService(); // <-- ✅ PERBAIKAN 3: Hapus kurung kurawal berlebih dari sini