import 'package:flutter/material.dart';
import 'package:dailymedicaltrivia2/ui/pages/CareerPage.dart';

class PrePlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.width * 0.65,
                child: Image.asset('assets/images/icon.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              );
            }),
            FlatButton(
              child: Text('Play'),
              onPressed: () {
                Navigator.pushNamed(context, '/career');
              },
            ),
          ],
        ),
      ),
    );
  }
}
