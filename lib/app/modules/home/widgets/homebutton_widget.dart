import 'package:flutter/material.dart';
import 'package:logcashflow/app/modules/home/controllers/home_controller.dart';

class ButtonHomeWidget extends StatelessWidget {
  final HomeController controller;
  final String text;
  final Color color;
  final IconData icon;
  final Function() func;
  const ButtonHomeWidget({
    Key? key,
    required this.controller,
    required this.text,
    required this.color,
    required this.func,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: func,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                child: Icon(
                  icon,
                  color: color,
                  size: 80,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
