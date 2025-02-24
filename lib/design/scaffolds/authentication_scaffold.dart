import 'package:flutter/material.dart';
import 'package:starter/design/widgets/widgets.dart';

class AuthenticationScaffold extends StatefulWidget {
  const AuthenticationScaffold({
    super.key,
    this.isRegister = false,
    required this.onTapButton,
    this.onRegister,
  });
  final bool isRegister;
  final Function()? onRegister;
  final Function(String email, String password, String? name) onTapButton;

  @override
  State<AuthenticationScaffold> createState() => _AuthenticationScaffoldState();
}

class _AuthenticationScaffoldState extends State<AuthenticationScaffold> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isRegister)
              CustomTextField(
                hintText: "name",
                controller: _nameController,
              ),
            CustomTextField(
              hintText: "email",
              controller: _emailController,
            ),
            CustomTextField(
              hintText: "password",
              controller: _passwordController,
              password: true,
            ),
            CustomButton(
              title: widget.isRegister ? "Register" : "Sign in",
              onTap: () {
                widget.onTapButton(
                  _emailController.text,
                  _passwordController.text,
                  widget.isRegister ? _nameController.text : null,
                );
              },
            ),
            Visibility(
              visible: widget.onRegister != null,
              child: InkWell(
                onTap: widget.onRegister,
                child: const Text("Doesn't have an acccount? Register here"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
