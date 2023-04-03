import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/src/constants/asset.dart';

class ProductImage extends StatefulWidget {
  final Function(File imageFile) callBack;

  const ProductImage(this.callBack, {Key? key}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildPickerImage(), _buildPreviewImage()],
      ),
    );
  }

  OutlinedButton _buildPickerImage() => (OutlinedButton.icon(
        onPressed: () {
          _modelPickerImage();
        },
        icon: const FaIcon(
          FontAwesomeIcons.image,
          color: Colors.grey,
        ),
        label: const Text(
          'image',
          style: TextStyle(color: Colors.grey),
        ),
      ));

  dynamic _buildPreviewImage() {
    if (_imageFile == null) {
      return const SizedBox();
    }
    container(Widget child) => Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          height: 350,
          child: child,
        );
    return Stack(
      children: [container(Image.file(_imageFile!)), _buildDeleteImageButton()],
    );
  }

  _buildDeleteImageButton() {
    return Positioned(
        child: IconButton(
      onPressed: () {
        setState(() {
          _imageFile = null;
        });
      },
      icon: const Icon(
        Icons.clear,
        color: Colors.black54,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ));
  }

  void _modelPickerImage() {
    buildListTile(IconData icon, String title, ImageSource imageSource) =>
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.pop(context);
            _pickImage(imageSource);
          },
        );
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildListTile(Icons.photo_camera, 'Take a picture from camera',
                    ImageSource.camera),
                buildListTile(Icons.photo_library, 'Select photo from library',
                    ImageSource.gallery)
              ],
            ));
  }

  void _pickImage(ImageSource imageSource) {
    _picker
        .pickImage(
            source: imageSource,
            maxHeight: 500,
            maxWidth: 500,
            imageQuality: 70)
        .then((file) {
      if (file != null) {
        setState(() {
          _cropImage(file.path);
        });
      }
    });
  }

  void _cropImage(String file) {
    ImageCropper().cropImage(
      sourcePath: file,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    ).then((file) => {
          if (file != null)
            {
              setState(() =>
                  {_imageFile = File(file.path), widget.callBack(_imageFile!)})
            }
        });
  }


}
