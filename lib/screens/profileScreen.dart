import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/helper/dialogs.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/auth/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final ChatUser user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.05,
                  ),
                  Stack(children: [
                    _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.file(
                              File(_image!),
                              fit: BoxFit.cover,
                              height: mq.height * .2,
                              width: mq.height * .2,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: CachedNetworkImage(
                              imageUrl: widget.user.image,
                              fit: BoxFit.cover,
                              height: mq.height * .2,
                              width: mq.height * .2,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                    Positioned(
                      right: -5,
                      bottom: 0,
                      child: MaterialButton(
                        color: Colors.white,
                        shape: CircleBorder(),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _showBottomSheet();
                        },
                        child: Icon(Icons.edit),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: mq.height * 0.01,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: mq.height * 0.04,
                  ),
                  TextFormField(
                    onSaved: (newValue) => Api.me.name = newValue ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
                    initialValue: widget.user.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(),
                        label: Text('Name')),
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (newValue) => Api.me.about = newValue ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.info,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(),
                        label: Text('About')),
                  ),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: Size(mq.width * 0.4, mq.height * .06)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Api.updateUserInfo().then((value) {
                            Dialogs.showSnackBar(
                                context, 'Profile Updated Sucessfullt!');
                          });
                        } else {}
                      },
                      icon: Icon(Icons.edit),
                      label: Text(
                        'Update',
                      ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await Api.auth.signOut();
            await GoogleSignIn().signOut().then((value) {
              // for progress bar to pop
              Navigator.pop(context);
              // for home screen to pop
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            });
          },
          icon: Icon(
            Icons.login_outlined,
          ),
          label: Text('Logout'),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: mq.height * 0.03, bottom: mq.height * 0.03),
            children: [
              const Text(
                "Pick Profile Picture",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(mq.width * .2, mq.height * .1)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      if (_image != null) {
                        log('Image path: ${image?.path}');
                        setState(() {
                          _image = image!.path;
                        });
                        Api.updateProfilePicture(File(_image!));
                      }
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/images/camera.png'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(mq.width * .2, mq.height * .1)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (_image != null) {
                          setState(() {
                            _image = image!.path;
                          });
                          Api.updateProfilePicture(File(_image!));
                        }
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/image.png'))
                ],
              )
            ],
          );
        });
  }
}
