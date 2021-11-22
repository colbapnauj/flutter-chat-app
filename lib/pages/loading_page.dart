import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(child: Text('Autenticando...'));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      socketService.connect();
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0)),
      );
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0)),
      );
    }
  }
}
