import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/models/product.dart';
import 'package:my_first_app/src/pages/management/widgets/product_image.dart';
import 'package:my_first_app/src/services/network_service.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _spacing = 12.0;
  late bool _isEdit;
  late final Product _product;
  final GlobalKey<FormState> _form = GlobalKey();
  File? _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    _isEdit = false;
    _product = Product(
        id: 0,
        name: "",
        image: "image",
        stock: 0,
        price: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
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
              ProductImage(callBack),
            ],
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
        TextButton(
          onPressed: () {
            _form.currentState?.save();
            addProduct();
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
        decoration: inputStyle('Name'),
        onSaved: (String? value) {
          _product?.name = value!.isEmpty ? '-' : value;
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('Price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product?.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('Stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product?.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  void addProduct() {
    NetworkService().addProduct(_product, imageFile: _imageFile).then((result) {
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
}
