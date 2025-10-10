import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../auth/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- STATE & CONTROLLERS ---
  late final TextEditingController _nameController; 
  late final TextEditingController _addressController;

  DateTime? _selectedDate = DateTime(1945, 1, 1);
  String? _selectedGender = 'Laki-laki';
  String? _selectedJobStatus = 'Presiden';

  bool _isLoading = false;
  // Untuk mengaktifkan tombol simpan jika ada perubahan
  bool _isFormDirty = false;
  File? _newPhoto;

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk mendeteksi perubahan
    _nameController = TextEditingController(text: authService.loggedInUser!.name);
    _addressController = TextEditingController(text: authService.loggedInUser!.address ?? '');
    _selectedGender = authService.loggedInUser!.gender;
    _selectedDate = authService.loggedInUser!.birthDate;
    _selectedJobStatus = authService.loggedInUser!.jobStatus;
    _nameController.addListener(_setFormDirty);
    _addressController.addListener(_setFormDirty);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _setFormDirty() {
    setState(() {
      _isFormDirty = true;
    });
  }

  // --- LOGIC ---
  Future<void> _selectDate(BuildContext context) async {
    final ImagePicker _picker = ImagePicker(); // Create an instance of ImagePicker
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Pick an image
    if (image != null) {
      setState(() {
        _newPhoto = File(image.path); // Convert XFile to File
        _isFormDirty = true; // Mark form as dirty since photo is changed
      });
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isFormDirty = true;
      });
    }
  }

 Future<void> _saveProfile() async {
  setState(() {
    _isLoading = true;
  });

  // Simulasi proses menyimpan data
  await Future.delayed(const Duration(seconds: 1));

  // ✅ BAGIAN PENTING: BUAT OBJEK USER BARU DENGAN DATA TERBARU
  if (mounted && authService.loggedInUser != null) {
    final updatedUser = authService.loggedInUser!.copyWith(
      // Ambil data terbaru dari controller dan state
      address: _addressController.text,
      birthDate: _selectedDate,
      jobStatus: _selectedJobStatus,
      gender: _selectedGender,
      photoPath: _newPhoto?.path,

      // Anda bisa tambahkan field lain di sini jika ada,
      // contoh: gender: _selectedGender,
    );

    // ✅ PANGGIL SERVICE UNTUK MEMPERBARUI DATA
    await authService.updateUser(updatedUser);
  }
  _newPhoto = null; // Reset foto baru setelah disimpan

  setState(() {
    _isLoading = false;
    _isFormDirty = false; // Reset form dirty setelah simpan
  });

    // Tampilkan notifikasi sukses
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0EA781),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Data berhasil disimpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              )
            ],
          ),
        ),
      );
    }
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfilePictureSection(),
                  const SizedBox(height: 24),
                  _buildProfileForm(),
                  const SizedBox(height: 32),
                  _buildSaveButton(),
                ],
              ),
            ),
          )
        ]);
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      pinned: true,
      title:  Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/profile_picture.png'),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Semangat Belajarnya,',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                authService.loggedInUser!.name,
                style: const TextStyle( // 'const' di sini boleh
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Buka Navigasi Menu'),
          ),
        ),
      ],
    );
  }

    Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Buka galeri untuk memilih gambar
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Simpan gambar yang dipilih ke dalam state
        _newPhoto = File(pickedFile.path);
        _isFormDirty = true; // Aktifkan tombol simpan
      });
    }
  }


    Widget _buildProfilePictureSection() {
    // Tentukan gambar mana yang akan ditampilkan
    ImageProvider backgroundImage;
    if (_newPhoto != null) {
      backgroundImage = FileImage(_newPhoto!); // Tampilkan foto baru
    } else if (authService.loggedInUser?.photoPath != null) {
      backgroundImage = FileImage(File(authService.loggedInUser!.photoPath!)); // Tampilkan foto tersimpan
    } else {
      backgroundImage = const AssetImage('assets/images/profile_picture.png'); // Tampilkan foto default
    }

    return Center(
      child: Column(
        children: [
          // ... (Teks "Edit Profil")
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar( // ✅ GUNAKAN VARIABLE backgroundImage
                radius: 48,
                backgroundImage: backgroundImage,
              ),
              // ... (Ikon edit)
            ],
          ),
          // ... (Teks deskripsi)
          ElevatedButton.icon(
            onPressed: _pickImage, // ✅ HUBUNGKAN FUNGSI KE TOMBOL INI
            icon: const Icon(Icons.upload),
            label: const Text('Upload Foto'),
            // ... (style)
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Data Diri',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTextField(label: 'Nama Lengkap', controller: _nameController, enabled: false),
        const SizedBox(height: 16),
        _buildDateField(),
        const SizedBox(height: 16),
        _buildDropdownField(
          label: 'Jenis Kelamin',
          value: _selectedGender,
          items: ['Laki-laki', 'Perempuan'],
          hint: 'Pilih jenis kelamin',
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
              _isFormDirty = true;
            });
          },
        ),
        const SizedBox(height: 24),
        _buildDropdownField(
          label: 'Status Pekerjaan',
          value: _selectedJobStatus,
          items: ['Pelajar', 'Mahasiswa', 'Karyawan', 'Wiraswasta', 'Presiden'],
          hint: 'Pilih status pekerjaanmu',
          onChanged: (value) {
            setState(() {
              _selectedJobStatus = value;
              _isFormDirty = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(label: 'Alamat Lengkap', controller: _addressController, maxLines: 3, hint: 'Masukkan alamat lengkap'),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    int maxLines = 1,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: !enabled,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tanggal Lahir', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            child: Text(
              _selectedDate == null
                  ? 'Masukkan tanggal lahirmu'
                  : DateFormat('d MMMM yyyy').format(_selectedDate!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    bool isButtonEnabled = _isFormDirty && !_isLoading;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? _saveProfile : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0EA781),
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                _isLoading ? 'Menyimpan Data...' : 'Simpan Perubahan',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
  
  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4, // Index 4 untuk 'Akun'
      selectedItemColor: const Color(0xFF0EA781),
      unselectedItemColor: const Color(0xFF6C6F70),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Kelas'),
        BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'Kelasku'),
        BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), label: 'koinLS'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Akun'),
      ],
      onTap: (index) {
        // Logika navigasi jika diperlukan
        if (index == 0) {
          // Navigasi ke Home
        }
      },
    );
  }
}