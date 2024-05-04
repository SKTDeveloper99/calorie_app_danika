import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:http/http.dart' as http;
import 'dart:typed_data';
// import 'dart:io';
// import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';

String getToday() {
  DateTime now = DateTime.now();

  // format to Day, Month Day
  String day = now.weekday.toString();
  switch (day) {
    case "1":
      day = "MONDAY";
      break;
    case "2":
      day = "TUESDAY";
      break;
    case "3":
      day = "WEDNESDAY";
      break;
    case "4":
      day = "THURSDAY";
      break;
    case "5":
      day = "FRIDAY";
      break;
    case "6":
      day = "SATURDAY";
      break;
    case "7":
      day = "SUNDAY";
      break;
  }

  // format to Month Day
  String month = now.month.toString();
  switch (month) {
    case "1":
      month = "JAN";
      break;
    case "2":
      month = "FEB";
      break;
    case "3":
      month = "MAR";
      break;
    case "4":
      month = "APR";
      break;
    case "5":
      month = "MAY";
      break;
    case "6":
      month = "JUN";
      break;
    case "7":
      month = "JUL";
      break;
    case "8":
      month = "AUG";
      break;
    case "9":
      month = "SEP";
      break;
    case "10":
      month = "OCT";
      break;
    case "11":
      month = "NOV";
      break;
    case "12":
      month = "DEC";
      break;
  }

  day = "$day, $month ${now.day}";

  return day;
}

Future<imglib.Image?> convertXFileToImageColor(XFile xFile) async {
  Uint8List bytes = await xFile.readAsBytes();
  // Use imglib to decode based on the file format
  imglib.Image? img = imglib.decodeImage(Uint8List.fromList(bytes));
  if (img == null) {
    print("Failed to decode image from XFile.");
    return null;
  }
  return img;
}

Future<http.Response> sendImageToServer(String url, imglib.Image image) async {
  // Encode the image to JPEG
  final Uint8List jpegImage = Uint8List.fromList(imglib.encodeJpg(image));

  // Encode the JPEG image to Base64
  String base64Image = base64Encode(jpegImage);

  // Make a POST request to the server
  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'image': base64Image,
    }),
  );

  return response;
}
