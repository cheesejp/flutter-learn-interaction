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
          FavoriteWidget(),
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

    Widget _highlightButtonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HighlightButton(),
        HighlightButton(),
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              _highlightButtonSection,
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: _isFavorited ? Icon(Icons.star) : Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
      } else {
        _favoriteCount += 1;
      }
      _isFavorited = !_isFavorited;
    });
  }
}

class HighlightButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HighlightButtonState();
}

class _HighlightButtonState extends State<HighlightButton> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HighlightButtonTmp(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class HighlightButtonTmp extends StatefulWidget {
  HighlightButtonTmp({@required this.active, @required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() => _HighlightButtonTmpState();
}

class _HighlightButtonTmpState extends State<HighlightButtonTmp> {
  bool _highlight = false;

  void _onTap() {
    print('tap');
    widget.onChanged(!widget.active);
  }

  void _onTapDown(TapDownDetails details) {
    print('tap down');
    setState(() {
      _highlight = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    print('tap up');
    setState(() {
      _highlight = false;
    });
  }

  void _onTapCancel() {
    print('tap cancel');
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        child: Align(
          child: Text(widget.active ? 'Active' : 'Inactive'),
          alignment: Alignment.center,
        ),
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen : Colors.grey[600],
          border: _highlight
              ? Border.all(color: Colors.teal[700], width: 5.0)
              : null,
        ),
        width: 100.0,
        height: 100.0,
      ),
    );
  }
}
