// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageProfileEdit extends StatefulWidget {
//   const ImageProfileEdit({super.key});

//   @override
//   _ImageProfileEditState createState() => _ImageProfileEditState();
// }

// class _ImageProfileEditState extends State<ImageProfileEdit> {
//   File? currentImage;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         setState(() {
//           currentImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error picking image: $e'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: [
//           Container(
//             width: 160,
//             height: 160,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 1,
//               ),
//               image: DecorationImage(
//                 image: currentImage != null
//                     ? FileImage(currentImage!) as ImageProvider
//                     : const AssetImage('assets/image/kk.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 5,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(5),
//                 child: const Icon(
//                   Icons.edit,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
