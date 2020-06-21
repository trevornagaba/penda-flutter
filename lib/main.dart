import 'package:flutter/material.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

final dummyUserSnapshot = [
  {"id": "", "name": "Trevor Nagaba", "email": "", "phone_number": "", "my_causes": ["", ""], "my_contributions": ["", ""]},
  {"id": "", "name": "Kaze Daudi", "email": "", "phone_number": "", "my_causes": ["", ""], "my_contributions": ["", ""]},
  {"id": "", "name": "Daudi Kaze", "email": "", "phone_number": "", "my_causes": ["", ""], "my_contributions": ["", ""]},
];

final dummyCauseSnapshot = [
  {"title": "event", "description": "", "creator": "Kaze", "target_amount": 100000, "due_date": "31/12/2020", 
  "current_amount": 20000, "category": "event", "contributors": ["", ""]
  },
  {"title": "another event", "description": "", "creator": "Kaze Daudi", "target_amount": 100000, "due_date": "31/12/2020", 
  "current_amount": 20000, "category": "event", "contributors": ["", ""]
  },
  {"title": "event une", "description": "", "creator": "Daudi Kaze", "target_amount": 100000, "due_date": "31/12/2020", 
  "current_amount": 20000, "category": "event", "contributors": ["", ""]
  },
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            // Putting a Column inside an Expanded widget stretches the column to use all remaining free space in the row.
            // Setting the crossAxisAlignment property to CrossAxisAlignment.start positions the column at the start of the row.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Putting the first row of text inside a Container enables you to add padding.
                // The second child in the Column, also text, displays as grey.
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
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
                ),
              ],
            ),
          ),
          // The last two items in the title row are a star icon, painted red, and the text “41”.
          // The entire row is in a Container and padded along each edge by 32 pixels.
          FavoriteWidget()
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // space the children (columns)  evenly
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'description placeholder text description placeholder text description placeholder text '
        'description placeholder text description placeholder text description placeholder text '
        'description placeholder text description placeholder text description placeholder text '
        'description placeholder text description placeholder text description placeholder text ',
        softWrap:
            true, // By setting softwrap to true, text lines will fill the column width before wrapping at a word boundary
      ),
    );

    return MaterialApp(
      title: 'Penda',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Penda'),
        ),
        body: Card(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Image.asset(
                'images/lake.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              titleSection,
              buttonSection,
              textSection,
            ],
          ),
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    // helper function for button section to prevent repitition
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  // The _toggleFavorite() method is called when the IconButton is pressed, calls setState(). Calling setState() is critical,
  // because this tells the framework that the widget’s state has changed and that the widget should be redrawn
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  // creates a row containing a red IconButton, and Text. You use IconButton (instead of Icon) because it has an onPressed property
  // that defines the callback function (_toggleFavorite) for handling a tap
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
