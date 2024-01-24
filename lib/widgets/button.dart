import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.text,
    this.color = Colors.black54,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final IconData iconData;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(iconData, size: 16, color: color),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      color: Colors.white,
      elevation: 0,
      textColor: const Color(0xFF323232),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xFFD6D6D6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 5.0),
          Icon(iconData),
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.total,
    required this.onPressed,
  }) : super(key: key);
  final String total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: const Color(0XFFF3F3F1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: const Color(0xFFFFE6D5),
                child: AssetImages.cardPos,
              ),
              const SizedBox(width: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Total payment',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'NGN $total',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  const SizedBox(width: 90),
                  Positioned(
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 10.0, 4.0),
                      color: const Color(0XFFD2EFE3),
                      child: const Text(
                        'boxed',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1A8A92),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 55,
                    child: AssetImages.wrappedPresent,
                  ),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: const MaterialStatePropertyAll(
              Colors.white,
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            minimumSize: const MaterialStatePropertyAll(
              Size(double.infinity, 48.0),
            ),
          ),
          child: const Text('Proceed to payment'),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          onPressed == null ? null : Theme.of(context).primaryColor,
        ),
        foregroundColor: const MaterialStatePropertyAll(
          Colors.white,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 48.0),
        ),
      ),
      child: Text(text),
    );
  }
}
