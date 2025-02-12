import 'package:flutter/material.dart';
import 'package:constriturar/app/views/modules/configuration/materials/materials_page.dart';
import 'package:constriturar/app/views/modules/home/home_page.dart';
import 'package:constriturar/app/core/services/auth_service.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.view});

  final Widget view;

  @override
  State<SideMenu> createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 288,
      height: double.infinity,
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            InfoCard(name: 'Santiago Henao', role: 'Administrador'),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 5, bottom: 5),
            ),
            SideMenuOptions(authService: _authService, view: widget.view),
          ],
        ),
      ),
    ));
  }
}

class SideMenuOptions extends StatefulWidget {
  const SideMenuOptions({
    super.key,
    required this.authService,
    required this.view,
  });

  final AuthService authService;
  final Widget view;

  @override
  State<SideMenuOptions> createState() => _SideMenuOptionsState();
}

class _SideMenuOptionsState extends State<SideMenuOptions> {
  final List<Map<String, dynamic>> menuItems = const [
    {
      'icon': Icons.home,
      'title': 'Inicio',
      'label': 'Dashboard',
      'isVisible': true,
      'view': HomePage(),
    },
    {
      'icon': Icons.people,
      'title': 'Clientes',
      'label': 'Clients',
      'isVisible': true,
      'view': HomePage(),
    },
    {
      'icon': Icons.cabin,
      'title': 'Materiales',
      'label': 'Materials',
      'isVisible': true,
      'view': MaterialsPage(),
    },
    {
      'icon': Icons.construction,
      'title': 'Obras',
      'label': 'Projects',
      'isVisible': true,
      'view': HomePage(),
    },
    {
      'icon': Icons.person_search,
      'title': 'Usuarios',
      'label': 'Users',
      'isVisible': true,
      'view': HomePage(),
    },
    {
      'icon': Icons.straighten,
      'title': 'Unidades',
      'label': 'Units',
      'isVisible': true,
      'view': HomePage(),
    },
    {
      'icon': Icons.directions_car,
      'title': 'Vehículos',
      'label': 'Vehicles',
      'isVisible': true,
      'view': HomePage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...menuItems.where((item) => item['isVisible']).map((item) {
          return Container(
            decoration: BoxDecoration(
              color: widget.view == item['view']
                  ? AppColors.lightPrimary
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              onTap: () {
                AppRoutes.setView(item['view'], context);
              },
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(item['icon'],
                    color: widget.view == item['view']
                        ? AppColors.primary
                        : AppColors.lightPrimary),
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                    color: widget.view == item['view']
                        ? AppColors.primary
                        : AppColors.lightPrimary),
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: Divider(
            color: AppColors.lightPrimary,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {
            // Eliminar los tokens del almacenamiento seguro
            widget.authService.logout();
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(Icons.logout, color: AppColors.lightPrimary),
          ),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(color: AppColors.lightPrimary),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.role,
  });

  final String name, role;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.lightPrimary,
        child: Icon(Icons.person, color: AppColors.primary),
      ),
      title: Text(
        name,
        style: TextStyle(color: AppColors.lightPrimary),
      ),
      subtitle: Text(role, style: TextStyle(color: AppColors.lightPrimary)),
    );
  }
}
