import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text ;
  const MainButton({super.key, required this.onPressed , required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
           style:ElevatedButton.styleFrom(
             backgroundColor: Theme.of(context).primaryColor,
           ) ,
          child: Text(text,
          style:Theme.of(context).textTheme.button,
          ),

      ),
    );
  }
}
