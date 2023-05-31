import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Scaffold(
        backgroundColor: const Color(0xFF040C23),
        appBar: AppBar(
          backgroundColor: const Color(0xFF040C23),
          elevation: 0,
          title: Text('Surah ${surah.name!.transliteration!.id}',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(Routes.SEARCH),
                icon: Icon(Icons.search)),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            GestureDetector(
                 onTap: () => Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                      ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF121931).withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Tafsir Surah ${surah.name!.transliteration!.id ?? 'Error...'}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                          ),
                 SizedBox(
                  height: 20,
                 ),
                  Text(
                    "${surah.tafsir?.id ?? "Data Tafsir sedang dalam proses Maintenance"}",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600
                    ),
                          ),
                        ],
                      ),

                    ),
                  ),
                 ),
              // Get.defaultDialog(
              //   contentPadding: EdgeInsets.symmetric(
              //     horizontal: 20,
              //     vertical: 10,
              //   ),
              //   title: "Tafsir Surah ${surah.name!.transliteration!.id ?? 'Error...'}",
              //   titleStyle: TextStyle(
              //     fontWeight: FontWeight.bold,
              //   ),
              //   content: Container(
              //     child: Text(
              //       "${surah.tafsir?.id ?? "Data Tafsir sedang dalam proses Maintenance"}",
              //       textAlign: TextAlign.justify,
              //       style: GoogleFonts.poppins(
              //         fontSize: 12,
              //         fontWeight: FontWeight.w500
              //       ),
              //     ),
              //   ),
              // ),
              child: Stack(
                children: [ 
                  Container(
                  height: 257,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, .6, 1],
                          colors: [
                            Color(0xFFDF98FA),
                            Color(0xFFB070FD),
                            Color(0xFF9055FF)
                          ],
                        ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Opacity(
                    opacity: .15,
                    child: SvgPicture.asset('assets/svgs/quran.svg',
                    width: 324 - 55,
                    ))),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "${surah.name!.transliteration!.id ?? 'Error...'}",
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "(${surah.name!.translation!.id ?? 'Error...'})",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(.35),
                          thickness: 2,
                          height: 32,
                        ),
                        Text(
                          "${surah.numberOfVerses ?? 'Error...'} Ayat | ${surah.revelation!.id ?? 'Error...'}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SvgPicture.asset("assets/svgs/bismillah.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
            }

            if (!snapshot.hasData) {
            return Center(
              child: Text("Data API Al-Qur'an sedang dalam proses Maintenance."),
            );
            }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.verses?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data?.verses?.length == 0){
                      return SizedBox();
                    }
                    detail.Verse? ayat = snapshot.data?.verses? [index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: const Color(0xFF121931),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ 
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/png/nomor-surah.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                
                                GetBuilder<DetailSurahController>(builder: (c) => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark_add_outlined),
                                      color: const Color(0xFFA44AFF),
                                    ),
                                    (ayat?.kondisiAudio == "stop") ? IconButton(
                                      onPressed: () {
                                        c.playAudio(ayat);
                                      },
                                      icon: Icon(Icons.play_arrow),
                                      color: const Color(0xFFA44AFF),
                                    ) : 
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        (ayat?.kondisiAudio == "playing") ? IconButton(
                                          onPressed: () {
                                            c.pauseAudio(ayat!);
                                        }, 
                                        icon: Icon(Icons.pause),
                                        color: const Color(0xFFA44AFF),
                                        ) 
                                        : IconButton(
                                          onPressed: () {
                                            c.resumeAudio(ayat!);
                                        }, 
                                        icon: Icon(Icons.play_arrow),
                                        color: const Color(0xFFA44AFF),
                                        ),
                                  IconButton(
                                    onPressed: () {
                                          c.stopAudio(ayat!);
                                    }, 
                                    icon: Icon(Icons.stop),
                                    color: const Color(0xFFA44AFF),
                                    ),
                                      ],
                                    ),
                                  ],
                                ),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("${ayat!.text?.arab}", 
                        textAlign: TextAlign.right,
                        style: GoogleFonts.amiri(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),),
                        SizedBox(height: 20),
                        Text("${ayat.translation?.id}", 
                        // textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFA19CC5),
                        ),),
                        SizedBox(height: 50),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
