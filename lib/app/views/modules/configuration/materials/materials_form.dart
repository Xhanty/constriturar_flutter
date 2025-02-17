import 'package:flutter/material.dart';
import 'package:constriturar/app/core/models/unit_model.dart';
import 'package:constriturar/app/widgets/drop_down_input_field.dart';
import 'package:constriturar/app/core/services/app/material_service.dart';
import 'package:constriturar/app/core/services/app/unit_service.dart';
import 'package:constriturar/app/core/models/material_model.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';

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
  final _unidadIdController = TextEditingController();

  final _unidadSearchController = TextEditingController();

  final MaterialService _materialService = MaterialService();
  final UnitService _unitsService = UnitService();

  List<UnitModel> _units = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadUnit();
    } else {
      _getUnits(null);
    }
  }

  void _loadUnit() async {
    setState(() {
      _isLoading = true;
    });
    final material =
        await _materialService.getById(MaterialModel(materialId: widget.id!));
    if (material != null) {
      _nameController.text = material.materialNombre!;
      _normaController.text = material.normaTecnica!;
      _valorController.text = material.valorBase.toString();
      _getUnits(material.unidadId);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _getUnits(int? unitId) async {
    final units = await _unitsService.getAll();

    if (units.isNotEmpty && widget.id != null && unitId != null) {
      UnitModel unit = units.where((unit) => unit.unidadId == unitId).first;
      _unidadIdController.text = unit.unidadId.toString();
      _unidadSearchController.text = unit.unidadDescripcion!;
    }

    setState(() {
      _units = units;
    });
  }

  void _handleUpdAdd() async {
    // Validar que los campos no estén vacíos
    if (_nameController.text.trim().isEmpty) {
      // Alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('El nombre es obligatorio'),
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
      return;
    }

    if (_normaController.text.trim().isEmpty) {
      // Alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('La norma técnica es obligatoria'),
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
      return;
    }

    if (_valorController.text.trim().isEmpty) {
      // Alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('El valor base es obligatorio'),
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
      return;
    }

    if (_unidadIdController.text.trim().isEmpty) {
      // Alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('La unidad es obligatoria'),
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
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final material = MaterialModel(
      materialId: widget.id ?? 0,
      materialNombre: _nameController.text,
      normaTecnica: _normaController.text,
      valorBase: double.parse(_valorController.text),
      unidadId: int.parse(_unidadIdController.text),
    );

    bool success;

    if (widget.id != null) {
      success = await _materialService.update(material);
    } else {
      success = await _materialService.create(material);
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error al ${widget.id != null ? 'modificar' : 'agregar'} el material')),
      );
    }
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                DropDownInputField<UnitModel>(
                  isMultiple: false,
                  searchController: _unidadSearchController,
                  data: _units,
                  onSuggestionSelected: (suggestion) {
                    _unidadIdController.text = suggestion.unidadId.toString();
                    _unidadSearchController.text =
                        suggestion.unidadDescripcion!;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      // leading: Icon(Icons.arrow_forward_ios),
                      title: Text(suggestion.unidadDescripcion!),
                    );
                  },
                  itemFilter: (unit, pattern) {
                    return unit.unidadDescripcion!
                        .toLowerCase()
                        .contains(pattern.toLowerCase());
                  },
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
