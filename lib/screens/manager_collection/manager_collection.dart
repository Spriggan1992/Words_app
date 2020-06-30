import 'package:flutter/material.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';

class CollectionManager extends StatelessWidget {
  static String id = 'collection_manager_screen';

  @override
  Widget build(BuildContext context) {
    bool isCheckedSecondWord = true;
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
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
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
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: temporaryData.length,
          itemBuilder: (context, index) {
            final item = temporaryData[index];
            return Dismissible(
              direction: DismissDirection.endToStart,
              // confirmDismiss: (bool confirm) {},
              onDismissed: (direction) {},
              background: Container(
                color: Color(0xFFF8b6b6),
              ),
              key: Key(item),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF878686),
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                            offset: Offset(1, 0.5))
                      ],
                      color: Colors.white,
                      // color: Colors.grey[200],
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 90.0,
                                  child: FittedBox(
                                    child: Text('Words',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFFF8b6b6))),
                                  ),
                                ),
                                isCheckedSecondWord
                                    ? Container(child: Text('Second Word'))
                                    : Container(),
                                Container(
                                  child: FittedBox(
                                      alignment: Alignment.center,
                                      child: Text('50%',
                                          style: TextStyle(
                                              fontSize: 3.0,
                                              color: Colors.red
                                                  .withOpacity(0.5)))),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: [0.5, 0.5],
                                        colors: [
                                          Colors.green,
                                          Color(0xFFf0f3f8)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text('Translation',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFFc9c97e))),
                              ),
                              Checkbox(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: false,
                                onChanged: null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}

// class CollectionManager extends StatelessWidget {
//   static String id = 'collection_manager_screen';
//   @override
//   Widget build(BuildContext context) {
//     List<String> temporaryData = [
//       'First',
//       'second',
//       'Third',
//       '212',
//       '231321',
//       'dsadsa',
//       '22222',
//       'dsadsa',
//       'fdsfds'
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: kMainColorBlue,
//         automaticallyImplyLeading: false,
//         title: Text('Collection Name'),
//       ),
//       floatingActionButton: ReusableFloatActionButton(),
//       bottomNavigationBar: BottomAppBar(
//         child: Container(
//           height: 60.0,
//           color: kMainColorBlue,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 color: Colors.grey[800].withOpacity(0.1),
//                 alignment: Alignment.center,
//                 height: 50.0,
//                 width: 200.0,
//                 child: ListView(
//                   itemExtent: 200,
//                   scrollDirection: Axis.horizontal,
//                   children: <Widget>[
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, CollectionManager.id),
//                       child: Text('Treining',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     ),
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, LoginScreen.id),
//                       child: Text('Loging',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     ),
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, RegistrationScreen.id),
//                       child: Text('Registration',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       body: Container(
//         padding: EdgeInsets.only(top: 30.0),
//         child: ListView.builder(
//           itemCount: temporaryData.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   // border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 child: ListTile(
//                   // isThreeLine: true,
//                   leading: Text('Second Word'),
//                   subtitle: Text('Somthingd dsadsadsadas fdsffffffffff'),
//                   // title: Text('dsadsa'),

//                   title: Text(
//                     (temporaryData[index]),
//                   ),
//                   trailing: Checkbox(
//                     value: false,
//                     onChanged: null,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
