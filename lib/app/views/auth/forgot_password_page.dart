import 'package:flutter/material.dart';
import 'package:constriturar/app/core/components/components.dart';
import 'package:constriturar/app/widgets/widgets.dart';
import 'package:constriturar/app/routes/routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

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
                const Upside(
                  imgUrl: "assets/images/register.png",
                ),
                const PageTitleBar(title: 'Restablecer contraseña'),
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
                        const SizedBox(
                          height: 15,
                        ),
                        iconButton(context),
                        const SizedBox(
                          height: 20,
                        ),
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
                              RoundedButton(text: 'RESTABLECER', press: () {}),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "¿Deseas iniciar sesión?",
                                navigatorText: "Inicia sesión",
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.login);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      RoundedIcon(imageUrl: "assets/images/facebook.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/images/google.jpg"),
    ],
  );
}
