import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final _textStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('title',
        style: _textStyle,
      ),
      subtitle: Text('subtitle',
        style: _textStyle,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Pedidos: 0',
            style: _textStyle,
          ),
          Text('Gasto: 0',
            style: _textStyle,
          ),
        ],
      ),
    );
  }
}
