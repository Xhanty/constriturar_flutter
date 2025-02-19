import 'package:flutter/material.dart';
import 'package:constriturar/app/core/helpers/validator.dart';
import 'package:constriturar/app/core/models/work_model.dart';
import 'package:constriturar/app/core/services/app/work_service.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';

class WorksForm extends StatefulWidget {
  const WorksForm({super.key, this.id});

  final int? id;

  @override
  State<WorksForm> createState() => _WorksFormState();
}

class _WorksFormState extends State<WorksForm> {
  final _nameController = TextEditingController();
  final WorkService _workService = WorkService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadWork();
    }
  }

  void _loadWork() async {
    setState(() {
      _isLoading = true;
    });
    final work = await _workService.getById(WorkModel(obraId: widget.id!));
    if (work != null) {
      _nameController.text = work.obraNombre!;
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
              widget.id != null ? 'Modificar obra' : 'Nueva obra',
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
