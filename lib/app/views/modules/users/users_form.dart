import 'package:flutter/material.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class UsersForm extends StatefulWidget {
  const UsersForm({super.key, this.id});

  final String? id;

  @override
  State<UsersForm> createState() => _UsersFormState();
}

class _UsersFormState extends State<UsersForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;

  void _handleUpdAdd() async {
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
              widget.id != null ? 'Modificar usuario' : 'Nuevo usuario',
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedInputField(
                  hintText: "Username",
                  icon: Icons.text_fields,
                  controller: _usernameController,
                ),
                RoundedInputField(
                  hintText: "Email",
                  icon: Icons.text_fields,
                  controller: _emailController,
                ),
                RoundedInputField(
                  hintText: "Teléfono",
                  icon: Icons.text_fields,
                  controller: _phoneController,
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
      ],
    );
  }
}
