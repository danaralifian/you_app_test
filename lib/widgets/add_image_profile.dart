import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageProfile extends StatefulWidget {
  final void Function(String?)? onChange;
  final String? profileImage;
  const AddImageProfile({super.key, this.onChange, this.profileImage});

  @override
  State<AddImageProfile> createState() => _AddImageProfileState();
}

class _AddImageProfileState extends State<AddImageProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.profileImage != null) {
      _imageFile = File(widget.profileImage!);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        widget.onChange?.call(_imageFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1B),
              borderRadius: BorderRadius.circular(16),
              image: _imageFile != null
                  ? DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _imageFile == null
                ? const Icon(Icons.add, color: Color(0xFFF3EDA6), size: 32)
                : null,
          ),
          const SizedBox(width: 12),
          const Text('Add image', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
