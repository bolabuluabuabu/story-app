import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.expand = false,
    this.password = false,
    this.focusNode,
  });
  final String hintText;
  final TextEditingController controller;
  final bool expand;
  final bool password;
  final FocusNode? focusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.password;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      color: widget.focusNode != null ? Colors.white : null,
      height: widget.expand ? 200 : null,
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            hintMaxLines: 1,
            hintText: widget.hintText,
            suffixIcon: widget.password
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null),
        maxLines: widget.expand ? null : 1,
        expands: widget.expand,
        textAlignVertical: TextAlignVertical.top,
        obscureText: _obscureText,
      ),
    );
  }
}
