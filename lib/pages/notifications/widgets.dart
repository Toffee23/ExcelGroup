import 'package:flutter/material.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    Key? key,
    this.onChanged,
    this.value,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final ValueChanged<bool>? onChanged;
  final bool? value;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onChanged?.call(!value!),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
      trailing: IgnorePointer(
        child: Transform.scale(
          scale: .7,
          child: Switch(
            value: value ?? false,
            activeColor: Theme.of(context).primaryColor,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
