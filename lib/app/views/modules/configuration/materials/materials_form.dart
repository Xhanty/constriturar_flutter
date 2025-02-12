import 'package:flutter/material.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class MaterialsForm extends StatefulWidget {
  const MaterialsForm({super.key, this.id});

  final int? id;

  @override
  State<MaterialsForm> createState() => _MaterialsFormState();
}

class _MaterialsFormState extends State<MaterialsForm> {
  final _nameController = TextEditingController();
  final _normaController = TextEditingController();
  final _valorController = TextEditingController();

  bool _isLoading = false;

  void _handleUpdAdd() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              widget.id != null ? 'Modificar material' : 'Nuevo material',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  RoundedInputField(
                    hintText: "Nombre",
                    icon: Icons.text_fields,
                    controller: _nameController,
                  ),
                  RoundedInputField(
                    hintText: "Norma técnica",
                    icon: Icons.text_fields,
                    controller: _normaController,
                  ),
                  RoundedInputField(
                    hintText: "Valor base",
                    icon: Icons.text_fields,
                    controller: _valorController,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text: widget.id != null ? 'Modificar' : 'Agregar',
                          press: _handleUpdAdd,
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
