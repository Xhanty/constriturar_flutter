import 'package:flutter/material.dart';
import 'package:constriturar/app/core/helpers/validator.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/core/models/unit_model.dart';
import 'package:constriturar/app/core/services/app/unit_service.dart';

class UnitsForm extends StatefulWidget {
  const UnitsForm({super.key, this.id});

  final int? id;

  @override
  State<UnitsForm> createState() => _UnitsFormState();
}

class _UnitsFormState extends State<UnitsForm> {
  final _nameController = TextEditingController();
  final UnitService _unitService = UnitService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadUnit();
    }
  }

  void _loadUnit() async {
    setState(() {
      _isLoading = true;
    });
    final unit = await _unitService.getById(UnitModel(unidadId: widget.id!));
    if (unit != null) {
      _nameController.text = unit.unidadDescripcion!;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _handleUpdAdd() async {
    // Validar los campos
    if (!validateMultipleFields(context, [_nameController])) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final unit = UnitModel(
      unidadId: widget.id ?? 0,
      unidadDescripcion: _nameController.text,
    );

    bool success;
    if (widget.id != null) {
      success = await _unitService.update(unit);
    } else {
      success = await _unitService.create(unit);
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Ocurrió un error al ${widget.id != null ? 'modificar' : 'agregar'} la unidad'),
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
    }
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
              widget.id != null ? 'Modificar unidad' : 'Nueva unidad',
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
                children: [
                  RoundedInputField(
                    hintText: "Nombre (*)",
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
