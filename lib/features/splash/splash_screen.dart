import 'package:flutter/material.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWidgetContainer(
      body: Center(
        child: GlobalText(text: 'Wanigo', variant: TextVariant.h4),
      ),
    );
  }
}