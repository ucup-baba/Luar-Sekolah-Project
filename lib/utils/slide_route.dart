import 'package:flutter/material.dart';

// Class ini adalah cetakan untuk transisi "geser dari kanan".
// Ia mewarisi (extends) PageRouteBuilder.
class SlideRightRoute extends PageRouteBuilder {
  final Widget page; // Halaman tujuan yang ingin kita tampilkan

  SlideRightRoute({required this.page})
      : super(
          // Durasi transisi
          transitionDuration: const Duration(milliseconds: 300),
          // pageBuilder hanya bertugas membangun widget halaman tujuan.
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          // transitionsBuilder adalah tempat kita membuat animasinya.
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            // Kita menggunakan Tween untuk mendefinisikan pergerakan.
            // Offset(1.0, 0.0) artinya mulai dari 100% ke kanan.
            // Offset.zero artinya berakhir di posisi normal (0,0).
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            
            // Curve menentukan bagaimana kecepatan animasi berubah seiring waktu.
            // Curves.easeOut membuat animasi melambat di akhir.
            var curve = Curves.easeOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // SlideTransition adalah widget yang benar-benar menggerakkan halaman.
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
