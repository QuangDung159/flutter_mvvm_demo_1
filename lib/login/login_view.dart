// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo_1/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      loginViewModel.passwordSink.add(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    loginViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
            stream: loginViewModel.emailStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Email',
                  labelText: 'Email: *',
                  errorText: snapshot.data,
                ),
              );
            },
          ),
          StreamBuilder<String>(
              stream: loginViewModel.passwordStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password: *',
                    errorText: snapshot.data,
                  ),
                );
              }),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<bool>(
            stream: loginViewModel.buttonStream,
            builder: (context, snapshot) {
              return TextButton(
                onPressed: () {
                  if (!snapshot.hasData) {
                    return;
                  } else {
                    if (snapshot.data!) {
                    } else {
                      return;
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: snapshot.data != null && snapshot.data!
                        ? Colors.blue[400]
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
