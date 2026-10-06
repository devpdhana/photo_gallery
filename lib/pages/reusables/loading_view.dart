import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message = 'Loading photos...'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 14),
          Text(message, style: context.theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
