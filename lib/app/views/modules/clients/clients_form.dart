import 'package:flutter/material.dart';
import 'package:constriturar/app/core/models/document_type_model.dart';
import 'package:constriturar/app/core/services/app/document_type_service.dart';
import 'package:constriturar/app/widgets/drop_down_input_field.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/rounded_button.dart';
import 'package:constriturar/app/widgets/rounded_input_field.dart';
import 'package:constriturar/app/core/helpers/validator.dart';
import 'package:constriturar/app/core/models/client_model.dart';
import 'package:constriturar/app/core/services/app/client_service.dart';

class ClientsForm extends StatefulWidget {
  const ClientsForm({super.key, this.id});

  final int? id;

  @override
  State<ClientsForm> createState() => _ClientsFormState();
}

class _ClientsFormState extends State<ClientsForm> {
  final _documentTypeController = TextEditingController();
  final _documentController = TextEditingController();
  final _namesController = TextEditingController();
  final _firstLastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _responsibleController = TextEditingController();

  final _documentTypeSearchController = TextEditingController();

  final ClientService _clientService = ClientService();
  final DocumentTypeService _documentService = DocumentTypeService();
  bool _isLoading = false;

  List<DocumentTypeModel> _documents = [];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadClient();
    } else {
      _getDocuments(null);
    }
  }

  void _loadClient() async {
    setState(() {
      _isLoading = true;
    });
    final client =
        await _clientService.getById(ClientModel(clienteId: widget.id!));
    if (client != null) {
      _getDocuments(client.tipoDocumento!.tipoDocumentoId);
      _namesController.text = client.nombres!;
      _firstLastNameController.text = client.primerApellido!;
      _secondLastNameController.text = client.segundoApellido!;
      _documentTypeController.text =
          client.tipoDocumento!.tipoDocumentoId.toString();
      _documentController.text = client.identificacion!;
      _responsibleController.text = client.encargado!;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _getDocuments(int? clientId) async {
    final documents = await _documentService.getAll();

    if (documents.isNotEmpty && widget.id != null && clientId != null) {
      DocumentTypeModel? documentType;
      final filteredClients = documents
          .where((documentType) => documentType.tipoDocumentoId == clientId);
      if (filteredClients.isNotEmpty) {
        documentType = filteredClients.first;
        _documentTypeController.text = documentType.tipoDocumentoId.toString();
        _documentTypeSearchController.text =
            documentType.tipoDocumentoDescripcion;
      }
    }

    setState(() {
      _documents = documents;
    });
  }

  void _handleUpdAdd() async {
    // Validar los campos
    if (!validateMultipleFields(context, [
      _documentTypeController,
      _documentController,
      _namesController,
      _firstLastNameController,
      _secondLastNameController,
      _responsibleController,
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
              widget.id != null ? 'Modificar cliente' : 'Nuevo cliente',
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
                  DropDownInputField<DocumentTypeModel>(
                    hintText: 'Tipo de documento (*)',
                    isMultiple: false,
                    searchController: _documentTypeSearchController,
                    data: _documents,
                    onSuggestionSelected: (suggestion) {
                      _documentTypeController.text =
                          suggestion.tipoDocumentoId.toString();
                      _documentTypeSearchController.text =
                          suggestion.tipoDocumentoDescripcion;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.arrow_forward_ios),
                        title: Text(suggestion.tipoDocumentoDescripcion),
                      );
                    },
                    itemFilter: (type, pattern) {
                      return type.tipoDocumentoDescripcion
                          .toLowerCase()
                          .contains(pattern.toLowerCase());
                    },
                  ),
                  RoundedInputField(
                    hintText: "Documento (*)",
                    icon: Icons.text_fields,
                    type: TextInputType.number,
                    controller: _documentController,
                  ),
                  RoundedInputField(
                    hintText: "Nombres (*)",
                    icon: Icons.text_fields,
                    controller: _namesController,
                  ),
                  RoundedInputField(
                    hintText: "Primer Apellido (*)",
                    icon: Icons.text_fields,
                    controller: _firstLastNameController,
                  ),
                  RoundedInputField(
                    hintText: "Segundo Apellido",
                    icon: Icons.text_fields,
                    controller: _secondLastNameController,
                  ),
                  RoundedInputField(
                    hintText: "Encargado (*)",
                    icon: Icons.text_fields,
                    controller: _responsibleController,
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
