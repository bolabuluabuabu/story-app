import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:starter/design/bloc/button/button_bloc.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.listenToButtonState = true,
  });

  final Function() onTap;
  final String title;
  final bool listenToButtonState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonBloc, ButtonState>(
      builder: (context, state) {
        if (listenToButtonState && state is ButtonErrorState) {
          return _buildContainer(child: Text(title), color: Colors.red);
        }

        if (listenToButtonState && state is ButtonLoadingState) {
          return _buildContainer(
            child: LoadingAnimationWidget.waveDots(
              color: Colors.black,
              size: 40,
            ),
          );
        }

        return InkWell(
          onTap: onTap,
          child: _buildContainer(child: Text(title)),
        );
      },
    );
  }

  Widget _buildContainer({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: color ?? Colors.amber,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      alignment: Alignment.center,
      child: child,
    );
  }
}
