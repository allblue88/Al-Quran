import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23),
      child: Scaffold(
        
        backgroundColor: const Color(0xFF040C23),
        appBar: AppBar(
          backgroundColor: const Color(0xFF040C23),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text("Al-Qur'an App",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600),),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(Routes.SEARCH),
                icon: Icon(Icons.search)),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assalamualaikum",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFFA19CC5),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  "Mas, Ngaji lagi yuk",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.LAST_READ),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 133,
                              width: Get.width,
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset('assets/svgs/quran.svg')),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/last-read.svg'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Last Read',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Al-Baqarah",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Ayat 255',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: const Color(0xFFA19CC5),
                  labelColor: Colors.white,
                  indicatorColor: const Color(0xFFA44AFF),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      child: Text(
                        "Surah",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Tafsir",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Favorite",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder(
                        future: controller.getAllSurah(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                  "Data API Al-Quran sedang dalam proses Maintenance."),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_SURAH,
                                      arguments: surah);
                                },
                                leading: Container(
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
                                      "${surah.number}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                title: Text(
                                    "${surah.name!.transliteration?.id ?? 'Error...'}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                    "${surah.numberOfVerses} Ayat | ${surah.revelation!.id}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                trailing: Text("${surah.name!.short}",
                                    style: GoogleFonts.amiri(
                                        color: const Color(0xFFA44AFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              );
                            },
                          );
                        },
                      ),
                      Center(
                        child: Text("page Tafsir"),
                      ),
                      Center(
                        child: Text("page Favorite"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ));
    
  }
}
