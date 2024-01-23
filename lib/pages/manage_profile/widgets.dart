import 'package:flutter/material.dart';

class ProfileSaveDialog extends StatelessWidget {
  const ProfileSaveDialog({
    Key? key,
    required this.onDiscard,
    required this.onSave,
  }) : super(key: key);
  final VoidCallback onDiscard;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Save')),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: Text(
              'Please rethink about your decision. '
              'Once you delete, there will be no going back. '
              'Please be certain.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              height: 15.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: onDiscard,
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.black87,
                  ),
                  foregroundColor: MaterialStatePropertyAll(
                    Colors.grey.shade100,
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  minimumSize: const MaterialStatePropertyAll(Size.zero),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  ),
                  textStyle: const MaterialStatePropertyAll(
                    TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                child: const Text('Discard'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: onSave,
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).primaryColor,
                  ),
                  foregroundColor: const MaterialStatePropertyAll(
                    Colors.white,
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  minimumSize: const MaterialStatePropertyAll(Size.zero),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  ),
                  textStyle: const MaterialStatePropertyAll(
                    TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                child: const Text('Yes, I want to save it'),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
