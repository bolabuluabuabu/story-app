import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter/design/bloc/button/design_bloc.dart';
import 'package:starter/design/widgets/widgets.dart';

class CreateStoryScaffold extends StatefulWidget {
  const CreateStoryScaffold({super.key, required this.onCreate, required this.onAddLocation});
  final Function(File photo, String description) onCreate;
  final Function()? onAddLocation;

  @override
  State<CreateStoryScaffold> createState() => _CreateStoryScaffoldState();
}

class _CreateStoryScaffoldState extends State<CreateStoryScaffold> {
  File? image;
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Create Story",
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            color: image == null ? Colors.grey : Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.center,
            child: image != null
                ? Image.file(image!)
                : const Text(
                    "Add image from Camera or Gallery",
                    textAlign: TextAlign.center,
                  ),
          ),
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  listenToButtonState: false,
                  onTap: () async {
                    final img = await _takePictureFromCamera();

                    if (img != null) {
                      _updateImage(img);
                    } else {
                      if (context.mounted) {
                        BlocProvider.of<SnackbarBloc>(context).add(
                          SnackBarTriggerEvent(
                            message: "Something went wrong",
                            color: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  title: 'Camera',
                ),
              ),
              Flexible(
                child: CustomButton(
                  listenToButtonState: false,
                  onTap: () async {
                    final img = await _chooseImageFromGallery();

                    if (img != null) {
                      _updateImage(img);
                    } else {
                      if (context.mounted) {
                        BlocProvider.of<SnackbarBloc>(context).add(
                          SnackBarTriggerEvent(
                            message: "Something went wrong",
                            color: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  title: 'Galery',
                ),
              ),
            ],
          ),
          CustomTextField(
            hintText: 'Description',
            expand: true,
            controller: _descriptionController,
          ),
          CustomButton(
            onTap: () {
              if (image != null && _descriptionController.text.isNotEmpty) {
                widget.onCreate(image!, _descriptionController.text);
              } else {
                BlocProvider.of<SnackbarBloc>(context).add(
                  SnackBarTriggerEvent(
                    message: "Image and description are required",
                    color: Colors.red,
                  ),
                );
              }
            },
            title: 'Create',
          ),
          Visibility(
            visible: widget.onAddLocation != null,
            child: CustomButton(
              listenToButtonState: false,
              onTap: () {
                if (widget.onAddLocation != null) {
                  widget.onAddLocation!();
                }
              },
              title: "Add Location",
            ),
          )
        ],
      ),
    );
  }

  Future<XFile?> _chooseImageFromGallery() async {
    try {
      final picker = ImagePicker();

      return await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }

  Future<XFile?> _takePictureFromCamera() async {
    try {
      final picker = ImagePicker();

      return await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }

  _updateImage(XFile file) {
    File(file.path);

    setState(() {
      image = File(file.path);
    });
  }
}
