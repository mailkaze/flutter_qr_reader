// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (valor!.contains('http')) {
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  String? valor;

  LatLng getLanLng() {
    // le quito la cabecera 'geo:' al string y el resto lo divido en dos por la coma
    final latLng = this.valor!.substring(4).split(',');
    // lat es un double de la primera mitad del array
    final lat = double.parse(latLng[0]);
    //lng es un double de la segunda mitad del array
    final lgn = double.parse(latLng[1]);

    return LatLng(lat, lgn);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
