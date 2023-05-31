import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040C23),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Al-Qur'an App",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Tadabbur Al-Qur'an dan\nMengamalkannya Setiap Hari",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFA19CC5),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 420,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF672CBC)),
                    child: SvgPicture.asset('assets/svgs/splash.svg'),
                  ),
                  Positioned(
                    left: 0,
                    bottom: -23,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => Get.offAllNamed(Routes.HOME),
                        style:  
                        ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          backgroundColor: Color(0xFFF9B091),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          )
                        ),
                          child: Text(
                            'Mulai Mengaji',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF091945),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
