import 'package:flutter/material.dart';
import 'package:constriturar/app/core/helpers/validator.dart';
import 'package:constriturar/app/core/models/user_model.dart';
import 'package:constriturar/app/widgets/drop_down_input_field.dart';
import 'package:constriturar/app/core/models/rol_model.dart';
import 'package:constriturar/app/core/services/app/user_service.dart';
import 'package:constriturar/app/widgets/rounded_password_field.dart';
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
  final _passwordController = TextEditingController();
  final _rolesIdController = TextEditingController();

  final _userSearchController = TextEditingController();

  final UserService _userService = UserService();

  List<RolModel> _roles = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadUser();
    } else {
      _getRoles(null);
    }
  }

  void _loadUser() async {
    setState(() {
      _isLoading = true;
    });
    final user = await _userService.getById(UserModel(id: widget.id!));
    if (user != null) {
      _usernameController.text = user.userName!;
      _emailController.text = user.email!;
      _phoneController.text = user.phoneNumber!;
      _getRoles(user.roles);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _getRoles(List<String>? rolesId) async {
    final roles = await _userService.getRoles();

    if (roles.isNotEmpty && widget.id != null && rolesId != null) {
      RolModel rol = roles.where((rol) => rol.role == rolesId.first).first;
      _rolesIdController.text = rol.role;
      _userSearchController.text = rol.role;
    }

    setState(() {
      _roles = roles;
    });
  }

  void _handleUpdAdd() async {
    // Validar los campos
    if (!validateMultipleFields(context, [
      _usernameController,
      _emailController,
      _phoneController,
      _passwordController
    ])) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
  }

  bool validateMultipleFields(
      BuildContext context, List<TextEditingController> controllers) {
    final validator = ValidatorHelper(controllers);

    if (validator.isRequired()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('Por favor, complete todos los campos obligatorios'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundedInputField(
                    hintText: "Username (*)",
                    icon: Icons.text_fields,
                    controller: _usernameController,
                  ),
                  widget.id == null
                      ? RoundedPasswordField(
                          controller: _passwordController,
                        )
                      : const SizedBox(),
                  RoundedInputField(
                    hintText: "Email (*)",
                    icon: Icons.text_fields,
                    controller: _emailController,
                  ),
                  RoundedInputField(
                    hintText: "Teléfono (*)",
                    icon: Icons.text_fields,
                    controller: _phoneController,
                  ),
                  DropDownInputField<RolModel>(
                    hintText: 'Roles (*)',
                    searchController: _userSearchController,
                    data: _roles,
                    onSuggestionSelected: (suggestion) {
                      _rolesIdController.text = suggestion.role;
                      _userSearchController.text = suggestion.role;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.arrow_forward_ios),
                        title: Text(suggestion.role),
                      );
                    },
                    itemFilter: (rol, pattern) {
                      return rol.role
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    },
                    isMultiple: false,
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
