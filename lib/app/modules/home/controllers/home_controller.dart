import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;
  RxString berat = "0".obs;

  RxString kodeKurir = "".obs;

  TextEditingController beratC = TextEditingController();

  List<Ongkir> ongkosKirim = [];

  RxBool isLoading = false.obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        kodeKurir != "" &&
        beratC.text != "") {
      try {
        isLoading.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": "e89fdb2ae1cac49971b18d7aca908608",
            "content-type": "application/x-www-form-urlencoded",
          },
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": beratC.text,
            "courier": kodeKurir.value,
          },
        );
        isLoading.value = false;
        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
          title: "ONGKIRIM",
          titleStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.pink,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map((e) => ListTile(
                      title: Text(e.service!.toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text("Rp. ${e.cost![0].value}",
                          style: const TextStyle(color: Colors.white)),
                    ))
                .toList(),
          ),
        );
      } catch (e) {
        Get.snackbar(
          'TERJADI KESALAHAN',
          'Tidak dapat mengecek ongkos kirim',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[900],
          colorText: Colors.white,
        );
      }
    } else {
      Get.defaultDialog(
        title: "TERJADI KESALAHAN",
        titleStyle: const TextStyle(color: Colors.white),
        middleText: "Data input belum lengkap",
        middleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.red[900],
      );
    }
  }
}
