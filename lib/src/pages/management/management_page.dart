import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/constants/api.dart';
import 'package:my_first_app/src/models/product.dart';
import 'package:my_first_app/src/pages/management/widgets/product_image.dart';
import 'package:my_first_app/src/services/network_service.dart';
import 'package:my_first_app/src/constants/asset.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _spacing = 12.0;
  late bool _isEdit;
  late Product _product;
  final GlobalKey<FormState> _form = GlobalKey();
  File? _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    _isEdit = false;
    _product = Product(
        id: 0,
        name: "",
        image: 'logo.png',
        stock: 0,
        price: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Product) {
      _isEdit = true;
      _product = arguments;
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(_spacing),
            child: Column(
              children: <Widget>[
                _buildNameInput(),
                SizedBox(
                  height: _spacing,
                ),
                Row(
                  children: <Widget>[
                    Flexible(child: _buildPriceInput()),
                    SizedBox(
                      width: _spacing,
                    ),
                    Flexible(child: _buildStockInput()),
                  ],
                ),
                ProductImage(
                    callBack,
                    _product.image.isNotEmpty
                        ? '${API.IMAGE_URL}/${_product?.image}'
                        : ''),
                const SizedBox(height: 80,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  callBack(File imageFile) {
    _imageFile = imageFile;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        if (_isEdit) _buildDeleteButton(),
        TextButton(
          onPressed: () {
            _form.currentState?.save();
            FocusScope.of(context).requestFocus(FocusNode());
            if (_isEdit) {
              editProduct();
            }else {
              addProduct();
            }
          },
          child: const Text(
            'submit',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  InputDecoration inputStyle(String label) => InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 2),
      ),
      labelText: label);

  TextFormField _buildNameInput() => TextFormField(
    initialValue: _product.name,
        decoration: inputStyle('Name'),
        onSaved: (String? value) {
          _product?.name = value!.isEmpty ? '-' : value;
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
    initialValue: _product.price.toString(),
        decoration: inputStyle('Price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product?.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  TextFormField _buildStockInput() => TextFormField(
    initialValue: _product.stock.toString(),
        decoration: inputStyle('Stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product?.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  void addProduct() {
    NetworkService().addProduct(_product!, imageFile: _imageFile).then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.circleXmark,
        color: Colors.red,
      );
    });
  }

  void showAlertBar(String message,
      {IconData icon = FontAwesomeIcons.circleCheck,
      Color color = Colors.green}) {
    Flushbar(
      message: message,
      icon: FaIcon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  _buildDeleteButton() => IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Delete Product'),
              content: Text('Are you sure you want to delete'),
              actions: <Widget>[
                TextButton(
                  child: Text('cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'ok',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    deleteProduct();
                  },
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.delete_outline));

  void deleteProduct() {
    NetworkService().deleteProduct(_product.id).then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.circleXmark,
        color: Colors.red,
      );
    });
  }

  void editProduct() {
    NetworkService().editProduct(_product, imageFile: _imageFile).then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.circleXmark,
        color: Colors.red,
      );
    });
  }
}
