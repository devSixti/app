// Archivo para editar el avatar

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Icon(Icons.person, size: 64, color: Color.fromRGBO(0, 0, 0, 1))
              : null,
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.edit, color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ],
    );
  }
}
