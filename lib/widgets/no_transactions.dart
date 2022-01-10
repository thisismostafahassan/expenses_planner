import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: constrains.maxHeight * 0.6,
              child: Image.asset('lib/assets/images/waiting.png'),
            ),
          ],
        );
      },
    );
  }
}
