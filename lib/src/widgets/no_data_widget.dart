import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  final String text;

  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://lottie.host/d06f4d2b-3123-44bc-9cbb-7e4bf3b2d7cd/J9CFpizpqe.json',
            height: 250,
            width: 250,
          ),
          SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
