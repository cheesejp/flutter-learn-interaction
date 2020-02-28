// ==========================================================================================================
// https://flutter.dev/docs/development/ui/layout/tutorial
// ==========================================================================================================
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: LayoutPage(
          title: 'Layout Demo',
        ),
      );
}

class LayoutPage extends StatelessWidget {
  LayoutPage({@required this.title});
  final String title;

  Widget _buildButtonColumn(Color color, IconData icon, String label,
          {double fontSize = 12, FontWeight fontWeight = FontWeight.w400}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    Widget _titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    MaterialColor iconColor = Colors.blue;
    Widget _iconSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButtonColumn(iconColor, Icons.call, 'CALL'),
        _buildButtonColumn(iconColor, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(iconColor, Icons.share, 'SHARE'),
      ],
    );

    Widget _textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Image.asset(
            //   'images/lake.jpg',
            //   width: 600,
            //   height: 240,
            //   fit: BoxFit.cover,
            // ),
            Container(
              width: 600,
              height: 240,
              child: Image.network(
                'https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg',
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: child,
                        )
                      : CircularProgressIndicator();
                },
              ),
            ),
            _titleSection,
            _iconSection,
            _textSection,
          ],
        ),
      ),
    );
  }
}
