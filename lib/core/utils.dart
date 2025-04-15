import 'dart:io' as io; 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

  String? _uploadedFileName;
  Uint8List? _fileBytes; // For web
  String? _filePath; // For mobile
void pickFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true, // Required for web
      withReadStream: false, // Optional for large files
    );

    if (result!= null) {
      _filePath = result.files.first.path;
      if (kIsWeb) {
        _fileBytes = result.files.first.bytes;
      }
      _uploadedFileName = result.files.first.name;
    
}
}

  void viewFile( BuildContext context ) {
    if (kIsWeb) {
      // Web: Display file from bytes
      if (_fileBytes != null) {
        showDialog(
          context: context,
          builder:
              (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300,
                  height: 400,
                  child:
                      _uploadedFileName!.endsWith('.jpg') ||
                              _uploadedFileName!.endsWith('.png') ||
                              _uploadedFileName!.endsWith('.jpeg')
                          ? Image.memory(_fileBytes!, fit: BoxFit.fill)
                          : Center(
                            child: const Text(
                              'Cannot preview this file type.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                ),
              ),
        );
      }
    } else {
      // Mobile: Display file from path
      if (_filePath != null) {
        showDialog(
          context: context,
          builder:
              (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300,
                  height: 500,
                  child:
                      _filePath!.endsWith('.jpg') ||
                              _filePath!.endsWith('.png') ||
                              _filePath!.endsWith('.jpeg')
                          ? Image.file(io.File(_filePath!), fit: BoxFit.fill)
                          : Center(
                            child: const Text(
                              'Cannot preview this file type.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                ),
              ),
        );
      }
    }
  }
