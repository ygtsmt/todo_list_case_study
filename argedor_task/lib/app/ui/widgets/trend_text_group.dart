import 'package:flutter/material.dart';

class TrendTextGroup extends StatelessWidget {
  const TrendTextGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '24H High (EUR)',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  const TextSpan(
                    text: '5,684.77',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '24H LOW (EUR)',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  const TextSpan(
                    text: '5,261.41',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '24H High VOL',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  const TextSpan(
                    text: '415,964.04',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'CAP (EUR)',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  const TextSpan(
                    text: '92.04B',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Circulation(BTC)',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  const TextSpan(
                    text: '17.20M',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
