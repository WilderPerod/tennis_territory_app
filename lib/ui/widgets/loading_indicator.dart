import 'package:flutter/material.dart';
import 'package:tennis_territory_app/config/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppTheme.primaryColor,
    ));
  }
}
