import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double spendingAmount;
  final double spendingOfPercentegeAmount;

  ChartBar(
      {this.dayLabel, this.spendingAmount, this.spendingOfPercentegeAmount});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: LayoutBuilder(
        builder: (context, Constraints) {
          return Column(
            children: [
              Container(
                height: Constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    spendingAmount.toStringAsFixed(0),
                  ),
                ),
              ),
              SizedBox(
                height: Constraints.maxHeight * 0.05,
              ),
              Container(
                height: Constraints.maxHeight * 0.6,
                width: 11,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingOfPercentegeAmount,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Constraints.maxHeight * 0.05,
              ),
              Container(
                height: Constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    dayLabel,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
