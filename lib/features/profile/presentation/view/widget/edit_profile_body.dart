import 'dart:io';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/widget/Custom_button.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/field_edit_prfile_body.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/text_edit_profile_app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBody extends StatefulWidget {
  final String email;
  final String role;

  const EditProfileBody({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  File? currentImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          currentImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          context.read<UserCubit>().getUserProfile();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile updated successfully")),
          );
        } else if (state is UpdateUserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update profile")),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 600,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: MediaQuery.of(context).size.width / 2 - 80,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: currentImage != null
                              ? FileImage(currentImage!) as ImageProvider
                              : const AssetImage('assets/image/kk.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextEditProfileAppTextfield(
              title: 'First Name',
              topPadding: 200,
            ),
            FieldEditPrfileBody(
              title: 'First Name',
              controller: firstNameController,
              topPadding: 240,
            ),
            const TextEditProfileAppTextfield(
                title: 'Last Name', topPadding: 300),
            FieldEditPrfileBody(
              title: 'Last Name',
              controller: lastNameController,
              topPadding: 335,
            ),
            const TextEditProfileAppTextfield(
              title: 'Phone Number',
              topPadding: 400,
            ),
            FieldEditPrfileBody(
              title: 'Phone Number',
              controller: phoneNumberController,
              topPadding: 435,
            ),
            const TextEditProfileAppTextfield(
              title: 'Location',
              topPadding: 500,
            ),
            FieldEditPrfileBody(
              title: 'Location',
              controller: locationController,
              topPadding: 535,
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 600),
                child: CustomButton(
                  text: 'Save Changes',
                  color: AppColors.goldenOrange,
                  onTap: () async {
                    Map<String, dynamic> updatedData = {
                      'email': widget.email,
                      'role': widget.role,
                    };

                    if (firstNameController.text.isNotEmpty) {
                      updatedData['name'] = firstNameController.text;
                    }

                    if (lastNameController.text.isNotEmpty) {
                      updatedData['lastName'] = lastNameController.text;
                    }

                    if (phoneNumberController.text.isNotEmpty) {
                      updatedData['phoneNumber'] = phoneNumberController.text;
                    }

                    if (locationController.text.isNotEmpty) {
                      updatedData['location'] = locationController.text;
                    }

                    File? imageFile = currentImage;

                    context.read<UserCubit>().updateUserProfile(
                          updatedData: updatedData,
                          imageFile: imageFile,
                        );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
