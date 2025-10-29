import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home/services/course_service.dart';
import '../../home/models/class_model.dart';
// (Anda perlu membuat halaman form 'add_edit_course_screen.dart' untuk ini)
// import 'add_edit_course_screen.dart'; 

class KelasAdminScreen extends StatelessWidget {
  const KelasAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan 'Consumer' untuk mendengarkan perubahan data
    return Consumer<CourseService>(
      builder: (context, courseService, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kelola Kelas'),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF0EA781), size: 30),
                onPressed: () {
                  // Pindah ke halaman form untuk 'Tambah Kelas'
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => AddEditCourseScreen()
                  // ));
                  
                  // -- ATAU UNTUK DEMO CEPAT --
                  // Kita buat data palsu baru saat tombol (+) ditekan
                  final demoCourse = ClassModel(
                    id: 'c${courseService.allCourses.length + 1}',
                    title: 'Kelas Baru Demo',
                    imagePath: 'https://placehold.co/100x92',
                    tags: ['Prakerja'],
                    rating: 5.0,
                    price: 1000000,
                  );
                  // Panggil service untuk membuat kursus baru
                  courseService.createCourse(demoCourse);
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: courseService.allCourses.length,
            itemBuilder: (context, index) {
              final course = courseService.allCourses[index];
              return ListTile(
                leading: Image.network(course.imagePath, width: 60, fit: BoxFit.cover),
                title: Text(course.title),
                subtitle: Text('Rp ${course.price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Pindah ke halaman form untuk 'Edit'
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) => AddEditCourseScreen(course: course)
                        // ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Panggil service untuk menghapus
                        courseService.deleteCourse(course.id);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
