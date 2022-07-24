import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http_parser/http_parser.dart';

class fileUpload extends StatefulWidget {
  const fileUpload({Key? key}) : super(key: key);

  @override
  State<fileUpload> createState() => _fileUploadState();
}

class _fileUploadState extends State<fileUpload> {
  late Response response;
  var path;
  var dio = Dio();

  void gethttp() async {
    response = await dio.post(path);
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    response = await dio.post(
        "https://api.imgbb.com/1/upload?expiration=600&key=359ae751c045090cace6910cbe8df5e4",
        data: formData);
    return response.data['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform
              .pickFiles(type: FileType.any, allowMultiple: false);
          if (result == null) return;
          if (result != null) {
            try {
              path = result.files.single.path;
              String fileName = result.files.single.name;
              FormData formData = FormData.fromMap({
                "file": await MultipartFile.fromFile(
                  path,
                  filename: fileName,
                  contentType: new MediaType("file", "jpg"),
                ),
                "type":"image/jpg"
              });

              print(fileName);
              response = await dio.post(
                "https://api.imgbb.com/1/upload?expiration=600&key=bf6bbaa9aa08b8a956710bd35b124f6c",
                data: formData,
                options: Options(
                  headers: {
                    "accept":"*/*",
                    "Content-Type":"multipart/form-data"
                  }
                )
              );
              print(response);
            } catch (e) {
              print(e);
            }
          }
        },
        child: Text('upload'),
      ),
    ));
  }
}
