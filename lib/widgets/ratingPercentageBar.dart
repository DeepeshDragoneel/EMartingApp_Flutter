import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RatingPercentageBar extends StatelessWidget {
  final num percentage;
  final String starNumber;
  const RatingPercentageBar(
      {Key? key, required this.percentage, required this.starNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(starNumber),
        Icon(
          Icons.star,
          size: 12,
          color: Colors.grey[400],
        ),
        LinearPercentIndicator(
          //leaner progress bar
          width: MediaQuery.of(context).size.width * 0.4,
          animation: true,
          animationDuration: 1000,
          lineHeight: 4.0,
          percent: percentage / 100,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: starNumber == '5'
              ? Colors.green[600]
              : starNumber == '4'
                  ? Colors.greenAccent
                  : starNumber == '3'
                      ? Colors.orangeAccent
                      : starNumber == '2'
                          ? Colors.redAccent
                          : starNumber == '1'
                              ? Colors.red
                              : Colors.grey,
          backgroundColor: Colors.grey[300],
        ),
        Text('${percentage}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
      ],
    );
  }
}
