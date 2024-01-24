import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.children,
    this.padding,
    this.margin,
  }) : super(key: key);
  final List<Widget> children;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 15.0),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15.0,
          ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
    required this.image,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final Image image;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(
            Size.zero,
          ),
          elevation: const MaterialStatePropertyAll(0),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 6.0,
            ),
          ),
          foregroundColor: MaterialStatePropertyAll(
            Colors.grey.shade800,
          ),
          backgroundColor: const MaterialStatePropertyAll(
            Colors.white,
          ),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            image,
            const SizedBox(width: 4.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Color(0xFF626568),
        ),
        foregroundColor: const MaterialStatePropertyAll(
          Colors.white70,
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(double.maxFinite, 40),
        ),
      ),
      child: Text(text),
    );
  }
}

class LinkTextField extends StatelessWidget {
  const LinkTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF626568),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
