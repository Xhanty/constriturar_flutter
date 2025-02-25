import 'package:flutter/material.dart';
import 'package:constriturar/app/core/models/city_model.dart';
import 'package:constriturar/app/core/models/department_model.dart';
import 'package:constriturar/app/core/services/app/cities.dart';
import 'package:constriturar/app/core/services/app/departments.dart';
import 'package:constriturar/app/core/services/app/client_service.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/widgets/drop_down_input_field.dart';
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
  final _clientIdController = TextEditingController();
  final _obraController = TextEditingController();
  final _phoneController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _deptoIdController = TextEditingController();
  final _cityIdController = TextEditingController();
  final _addressController = TextEditingController();

  final _clientSearchController = TextEditingController();
  final _deptoSearchController = TextEditingController();
  final _citySearchController = TextEditingController();

  final WorkService _workService = WorkService();
  final ClientService _clientService = ClientService();
  final DepartmentService _deptoService = DepartmentService();
  final CityService _cityService = CityService();

  bool _isLoading = false;
  List<ClientModel> _clients = [];
  List<DepartmentModel> _departments = [];
  List<CityModel> _cities = [];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadWork();
    } else {
      _getClients(null);
      _getDepartments(null);
    }
  }

  void _loadWork() async {
    setState(() {
      _isLoading = true;
    });
    final work = await _workService.getById(WorkModel(obraId: widget.id!));
    if (work != null) {
      _getClients(work.cliente?.clienteId);
      _getDepartments(work.departamento?.departamentoId);
      _getCities(
          work.departamento!.departamentoId, work.municipio!.municipioId);
      _obraController.text = work.obraNombre!;
      _phoneController.text = work.telefono!;
      _contactController.text = work.nombreContacto!;
      _locationController.text = work.ubicacion!;
      _addressController.text = work.direccion!;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _getClients(int? clientId) async {
    final clients = await _clientService.getAll();

    if (clients.isNotEmpty && widget.id != null && clientId != null) {
      ClientModel? client;
      final filteredClients =
          clients.where((client) => client.clienteId == clientId);
      if (filteredClients.isNotEmpty) {
        client = filteredClients.first;
        _clientIdController.text = client.clienteId.toString();
        _clientSearchController.text = client.nombreCompleto!;
      }
    }

    setState(() {
      _clients = clients;
    });
  }

  void _getDepartments(int? departamentoId) async {
    final departments = await _deptoService.getAll();

    if (departments.isNotEmpty && widget.id != null && departamentoId != null) {
      DepartmentModel? department;
      final filteredDepartments = departments
          .where((department) => department.departamentoId == departamentoId);
      if (filteredDepartments.isNotEmpty) {
        department = filteredDepartments.first;
        _deptoIdController.text = department.departamentoId.toString();
        _deptoSearchController.text = department.departamentoNombre;
      }
    }

    setState(() {
      _departments = departments;
    });
  }

  void _getCities(int departamentoId, int municipioId) async {
    final cities = await _cityService.getByDepartment(departamentoId);

    if (cities.isNotEmpty && widget.id != null && municipioId > 0) {
      CityModel? city;
      final filteredCities =
          cities.where((city) => city.municipioId == municipioId);
      if (filteredCities.isNotEmpty) {
        city = filteredCities.first;
        _cityIdController.text = city.municipioId.toString();
        _citySearchController.text = city.municipioNombre;
      }
    } else {
      // Para nueva obra o si no hay municipio seleccionado
      _citySearchController.clear();
      _cityIdController.clear();
    }

    setState(() {
      _cities = cities;
    });
  }

  void _handleUpdAdd() async {
    // Validar los campos
    if (!validateMultipleFields(context, [
      _clientIdController,
      _obraController,
      _phoneController,
      _contactController,
      _locationController,
      _deptoIdController,
      _cityIdController,
      _addressController
    ])) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final work = WorkModel(
      obraId: widget.id ?? 0,
      clienteId: int.parse(_clientIdController.text),
      empresaId: 1, // Cambiar por el id de la empresa de la sesión
      obraNombre: _obraController.text,
      telefono: _phoneController.text,
      nombreContacto: _contactController.text,
      ubicacion: _locationController.text,
      departamentoId: int.parse(_deptoIdController.text),
      municipioId: int.parse(_cityIdController.text),
      direccion: _addressController.text,
    );

    bool success;

    if (widget.id != null) {
      success = await _workService.update(work);
    } else {
      success = await _workService.create(work);
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
                'Ocurrió un error al ${widget.id != null ? 'modificar' : 'agregar'} la obra'),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropDownInputField<ClientModel>(
                    hintText: 'Cliente (*)',
                    isMultiple: false,
                    searchController: _clientSearchController,
                    data: _clients,
                    onSuggestionSelected: (suggestion) {
                      _clientIdController.text =
                          suggestion.clienteId.toString();
                      _clientSearchController.text = suggestion.nombreCompleto!;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.arrow_forward_ios),
                        title: Text(suggestion.nombreCompleto!),
                      );
                    },
                    itemFilter: (client, pattern) {
                      return client.nombreCompleto!
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    },
                  ),
                  DropDownInputField<DepartmentModel>(
                    hintText: 'Departamento (*)',
                    isMultiple: false,
                    searchController: _deptoSearchController,
                    data: _departments,
                    onSuggestionSelected: (suggestion) {
                      _deptoSearchController.text =
                          suggestion.departamentoNombre;
                      _deptoIdController.text =
                          suggestion.departamentoId.toString();
                      _citySearchController.clear();
                      _cityIdController.clear();
                      _getCities(suggestion.departamentoId,
                          0); // Se puede pasar 0 o un valor por defecto para indicar "sin municipio seleccionado"
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.arrow_forward_ios),
                        title: Text(suggestion.departamentoNombre),
                      );
                    },
                    itemFilter: (department, pattern) {
                      return department.departamentoNombre
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    },
                  ),
                  DropDownInputField<CityModel>(
                    hintText: 'Municipio (*)',
                    isMultiple: false,
                    searchController: _citySearchController,
                    data: _cities,
                    onSuggestionSelected: (suggestion) {
                      _cityIdController.text =
                          suggestion.municipioId.toString();
                      _citySearchController.text = suggestion.municipioNombre;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.arrow_forward_ios),
                        title: Text(suggestion.municipioNombre),
                      );
                    },
                    itemFilter: (city, pattern) {
                      return city.municipioNombre
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    },
                  ),
                  RoundedInputField(
                    hintText: "Obra (*)",
                    icon: Icons.text_fields,
                    controller: _obraController,
                  ),
                  RoundedInputField(
                    hintText: "Teléfono (*)",
                    icon: Icons.text_fields,
                    type: TextInputType.phone,
                    controller: _phoneController,
                  ),
                  RoundedInputField(
                    hintText: "Contacto (*)",
                    icon: Icons.text_fields,
                    controller: _contactController,
                  ),
                  RoundedInputField(
                    hintText: "Ubicación (*)",
                    icon: Icons.text_fields,
                    controller: _locationController,
                  ),
                  RoundedInputField(
                    hintText: "Dirección (*)",
                    icon: Icons.text_fields,
                    controller: _addressController,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text: widget.id != null ? 'Modificar' : 'Agregar',
                          press: _handleUpdAdd,
                        ),
                  // RoundedButton(
                  //   text: 'Cancelar',
                  //   press: () {
                  //     Navigator.pop(context);
                  //   },
                  //   backgroundColor: ThemeData().scaffoldBackgroundColor,
                  //   textColor: AppColors.primary,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
