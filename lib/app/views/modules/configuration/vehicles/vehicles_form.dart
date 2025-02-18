import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/core/helpers/validator.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/models/vehicle_model.dart';
import 'package:constriturar/app/core/services/app/vehicle_service.dart';

class VehiclesForm extends StatefulWidget {
  const VehiclesForm({super.key, this.id});

  final int? id;

  @override
  State<VehiclesForm> createState() => _VehiclesFormState();
}

class _VehiclesFormState extends State<VehiclesForm> {
  final _descripcionController = TextEditingController();
  final _capacidadController = TextEditingController();
  final _fechaVenceSoatController = TextEditingController();
  final _fechaVenceTecnoController = TextEditingController();
  final _modeloController = TextEditingController();
  final _marcaController = TextEditingController();
  final _placaController = TextEditingController();
  final VehicleService _vehicleService = VehicleService();
  bool _isLoading = false;
  late DateTime fechaSoatDate;
  late DateTime fechaTecnoDate;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadVehicle();
    }
  }

  void _loadVehicle() async {
    setState(() {
      _isLoading = true;
    });
    final vehicle =
        await _vehicleService.getById(VehicleModel(vehiculoId: widget.id!));
    if (vehicle != null) {
      fechaSoatDate = DateTime.parse(vehicle.fechaVenceSoat!);
      fechaTecnoDate = DateTime.parse(vehicle.fechaVenceTecno!);

      _descripcionController.text = vehicle.vehiculoDescripcion!;
      _capacidadController.text = vehicle.capacidad.toString();
      _fechaVenceSoatController.text =
          "${fechaSoatDate.year}-${fechaSoatDate.month}-${fechaSoatDate.day}";
      _fechaVenceTecnoController.text =
          "${fechaTecnoDate.year}-${fechaTecnoDate.month}-${fechaTecnoDate.day}";
      _modeloController.text = vehicle.modelo!;
      _marcaController.text = vehicle.marca!;
      _placaController.text = vehicle.placa!;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _handleUpdAdd() async {
    // Validar los campos
    if (!validateMultipleFields(context, [
      _descripcionController,
      _capacidadController,
      _fechaVenceSoatController,
      _fechaVenceTecnoController,
      _modeloController,
      _marcaController,
      _placaController
    ])) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final vehicle = VehicleModel(
      vehiculoId: widget.id ?? 0,
      vehiculoDescripcion: _descripcionController.text,
      capacidad: int.parse(_capacidadController.text),
      fechaVenceSoat: _fechaVenceSoatController.text,
      fechaVenceTecno: _fechaVenceTecnoController.text,
      modelo: _modeloController.text,
      marca: _marcaController.text,
      placa: _placaController.text,
    );

    bool success;
    if (widget.id != null) {
      success = await _vehicleService.update(vehicle);
    } else {
      success = await _vehicleService.create(vehicle);
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
                'Ocurrió un error al ${widget.id != null ? 'modificar' : 'agregar'} el vehículo'),
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
              widget.id != null ? 'Modificar vehículo' : 'Nuevo vehículo',
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
                    controller: _descripcionController,
                  ),
                  RoundedInputField(
                    hintText: "Capacidad (*)",
                    icon: Icons.text_fields,
                    type: TextInputType.number,
                    controller: _capacidadController,
                  ),
                  RoundedInputField(
                    hintText: "Vencimiento Soat (*)",
                    icon: Icons.date_range,
                    controller: _fechaVenceSoatController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            widget.id != null ? fechaSoatDate : DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        setState(() {
                          _fechaVenceSoatController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  RoundedInputField(
                    hintText: "Vencimiento Tecnomecanica (*)",
                    icon: Icons.date_range,
                    controller: _fechaVenceTecnoController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            widget.id != null ? fechaTecnoDate : DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        setState(() {
                          _fechaVenceTecnoController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  RoundedInputField(
                    hintText: "Modelo (*)",
                    icon: Icons.text_fields,
                    controller: _modeloController,
                  ),
                  RoundedInputField(
                    hintText: "Marca (*)",
                    icon: Icons.text_fields,
                    controller: _marcaController,
                  ),
                  RoundedInputField(
                    hintText: "Placa (*)",
                    icon: Icons.text_fields,
                    controller: _placaController,
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
