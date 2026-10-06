import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: context.colorScheme.outline),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
