import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
 // RxString kondisiAudio = "stop".obs;
  
  
  final player = AudioPlayer();

  Verse? lastVerse;

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    print(url);
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return DetailSurah.fromJson(data);
  }


  void stopAudio(Verse ayat) async {
    try {

      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
      
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Data Audio Ayat sedang dalam proses Maintenance.",
      );
    }
  }


  void resumeAudio(Verse ayat) async {
    try {

      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();

    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Data Audio Ayat sedang dalam proses Maintenance.",
      );
    }
  }


  void pauseAudio(Verse ayat) async {
    try {

      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
      
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Data Audio Ayat sedang dalam proses Maintenance.",
      );
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      //proses
      try {
        //mencegah terjadinya penumpukan audio yg sedang berjalan
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();

      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Warning",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Warning",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Warning",
          middleText: "Data Audio Ayat sedang dalam proses Maintenance.",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Data Audio Ayat sedang dalam proses Maintenance.",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
