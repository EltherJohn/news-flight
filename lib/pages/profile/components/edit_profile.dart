import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileUI extends StatefulWidget {
  final User? user;
  final VoidCallback refresh;
  const EditProfileUI({super.key, required this.user, required this.refresh});

  @override
  State<EditProfileUI> createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  final _userController = TextEditingController();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _userController.text = widget.user?.displayName ?? '';
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: _image != null
                  ? MemoryImage(_image!)
                  : widget.user?.photoURL != null
                      ? NetworkImage(widget.user!.photoURL!)
                      : const AssetImage('assets/default_profile_image.png') as ImageProvider,
            ),
            ElevatedButton(
              onPressed: selectImage,
              child: const Text('Choose Profile Picture'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newName = _userController.text.trim();
                if (newName.isNotEmpty) {
                  // Update username if changed
                  if (newName != widget.user?.displayName) {
                    // Update display name in Firebase Auth
                    await widget.user?.updateDisplayName(newName);

                    // Update username in Firestore database
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user?.uid)
                        .update({'username': newName});
                  }

                  // Update profile picture if changed
                  if (_image != null) {
                    // Upload image to Firebase Storage
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child('profile_pictures')
                        .child('${widget.user?.uid}.jpg');
                    await storageRef.putData(_image!);

                    // Get download URL of the uploaded image
                    final String downloadURL =
                        await storageRef.getDownloadURL();

                    // Update profile image URL in Firestore database
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user?.uid)
                        .update({'profileImageURL': downloadURL});
                  }
                  // Refresh UI
                  widget.refresh();
                  // Close the edit profile screen
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
