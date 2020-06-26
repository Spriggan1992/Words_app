import 'package:flutter/material.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';

class CollectionManager extends StatelessWidget {
  static String id = 'collection_manager_screen';
  @override
  Widget build(BuildContext context) {
    List<String> temporaryData = [
      'First',
      'second',
      'Third',
      '212',
      '231321',
      'dsadsa',
      '22222',
      'dsadsa',
      'fdsfds'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColorBlue,
        automaticallyImplyLeading: false,
        title: Text('Collection Name'),
      ),
      floatingActionButton: ReusableFloatActionButton(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          color: kMainColorBlue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey[800].withOpacity(0.1),
                alignment: Alignment.center,
                height: 50.0,
                width: 200.0,
                child: ListView(
                  itemExtent: 200,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    FlatButton(
                      onPressed: null,
                      // Navigator.pushNamed(context, CollectionManager.id),
                      child: Text('Treining',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    ),
                    FlatButton(
                      onPressed: null,
                      // Navigator.pushNamed(context, LoginScreen.id),
                      child: Text('Loging',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    ),
                    FlatButton(
                      onPressed: null,
                      // Navigator.pushNamed(context, RegistrationScreen.id),
                      child: Text('Registration',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: ListView.builder(
          itemCount: temporaryData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  title: Text(
                    (temporaryData[index]),
                  ),
                  trailing: Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
