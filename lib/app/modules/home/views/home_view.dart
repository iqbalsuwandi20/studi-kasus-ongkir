import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text(
          'Ongkos Kirim',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.province ?? "Pilih Provinsi"),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text("${item.province}"),
                );
              },
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Asal Provinsi",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "e89fdb2ae1cac49971b18d7aca908608"},
              );

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.cityName ?? "Pilih Kota"),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                );
              },
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Asal Kota",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?&province=${controller.provAsalId}",
                queryParameters: {"key": "e89fdb2ae1cac49971b18d7aca908608"},
              );

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<Province>(
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.province ?? "Pilih Provinsi Tujuan"),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text("${item.province}"),
                );
              },
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "e89fdb2ae1cac49971b18d7aca908608"},
              );

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.cityName ?? "Pilih Kota Tujuan"),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                );
              },
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?&province=${controller.provTujuanId}",
                queryParameters: {"key": "e89fdb2ae1cac49971b18d7aca908608"},
              );

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "0",
          ),
          const SizedBox(height: 20),
          DropdownSearch<Map<String, dynamic>>(
            items: const [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "POS Indonesia",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
            ],
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?["name"] ?? "Pilih Kurir"),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text("${item["name"]}"),
                );
              },
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
            child: const Text(
              "CEK ONGKOS KIRIM",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
