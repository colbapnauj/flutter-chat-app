import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firebaseappconfig_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/botton_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    image: 'assets/icon/pengchat-icon.png',
                    text: 'Pengchat',
                  ),
                  Form(),
                  const Labels(
                      title: '¿No tienes cuenta?',
                      subtitle: 'Crea una ahora!',
                      ruta: 'register'),
                  // TODO Términos
                  const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  FormState createState() => FormState();
}

class FormState extends State<Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
            textController: passCtrl,
            isPassword: true,
          ),
          ButtonBlue(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    try {
                      final loginOK = await authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());

                      if (loginOK) {
                        socketService.connect();
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        if (!mounted) return;
                        mostrarAlerta(context, "Login incorrecto",
                            "Revise sus credenciales");
                      }
                    } catch ( e) {
                      mostrarAlerta(
                          context, "Error", e as String? ?? 'Algo salió mal');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
