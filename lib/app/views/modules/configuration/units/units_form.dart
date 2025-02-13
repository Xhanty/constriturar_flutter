import 'package:flutter/material.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class UnitsForm extends StatefulWidget {
  const UnitsForm({super.key, this.id});

  final int? id;

  @override
  State<UnitsForm> createState() => _UnitsFormState();
}

class _UnitsFormState extends State<UnitsForm> {
  final _nameController = TextEditingController();

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
              widget.id != null ? 'Modificar unidad' : 'Nueva unidad',
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
