import 'package:flutter/material.dart';
import 'package:constriturar/app/core/services/secure_storage_service.dart';
import 'package:constriturar/app/core/components/components.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:constriturar/app/widgets/widgets.dart';
import 'package:constriturar/app/routes/routes.dart';
import 'package:constriturar/app/core/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final SecureStorageService _secureStorageService = SecureStorageService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkTokens();
  }

  void _checkTokens() async {
    final accessToken = await _secureStorageService.getAccessToken();
    final refreshToken = await _secureStorageService.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.mainPages);
    }
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Completa todos los campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await _authService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (response.containsKey('error')) {
      _showSnackBar(response['error']);
    } else {
      _showSnackBar('Inicio de sesión exitoso');
      Navigator.pushReplacementNamed(context, AppRoutes.mainPages);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(imgUrl: "assets/images/login.png"),
                const PageTitleBar(title: 'Ingresa a tu cuenta'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        iconButton(context),
                        const SizedBox(height: 20),
                        const Text(
                          "O ingresa con tu correo",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Gilroy',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Correo electrónico",
                                icon: Icons.email,
                                controller: _emailController,
                              ),
                              RoundedPasswordField(
                                controller: _passwordController,
                              ),
                              switchListTile(),
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : RoundedButton(
                                      text: 'INGRESAR',
                                      press: _handleLogin,
                                    ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.forgotPassword);
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

switchListTile() {
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 40),
    child: SwitchListTile(
      dense: true,
      title: const Text(
        'Recuérdame',
        style: TextStyle(fontSize: 16, fontFamily: 'Gilroy'),
      ),
      value: true,
      activeColor: AppColors.primary,
      onChanged: (val) {},
    ),
  );
}

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      RoundedIcon(imageUrl: "assets/images/facebook.png"),
      SizedBox(width: 20),
      RoundedIcon(imageUrl: "assets/images/google.jpg"),
    ],
  );
}
