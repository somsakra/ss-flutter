import 'package:flutter/material.dart';
import 'package:my_first_app/src/models/product.dart';
import 'package:my_first_app/src/pages/management/widgets/product_image.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    _isEdit = false;
    _product = Product(id: 0, name: "", image: "image", stock: 0, price: 0, createdAt: DateTime.now(), updatedAt: DateTime.now());
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
              const ProductImage(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        TextButton(
          onPressed: () {
            _form.currentState?.save();
            print(_product.name);
            print(_product.price.toString());
            print(_product.stock.toString());
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
}
