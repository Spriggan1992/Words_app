import 'package:flutter/material.dart';

class BoxCollection extends StatefulWidget {
  BoxCollection({
    this.textTitle,
    this.deleteColection,
    this.onTap,
    this.isChecked,
    this.onSubmite,
    this.onChanged,
  });

  final String textTitle;
  final Function deleteColection;
  final Function onTap;
  final bool isChecked;
  final Function onSubmite;
  final Function onChanged;

  @override
  _BoxCollectionState createState() => _BoxCollectionState();
}

class _BoxCollectionState extends State<BoxCollection> {
  TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.deleteColection,
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF878686),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(1, 0.5))
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 5.0,
                  top: 5,
                ),
                child: Text('Eng', style: TextStyle(fontSize: 10.0)),
              ),
              Container(
                alignment: Alignment.center,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.isChecked
                          ? Expanded(
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1, right: 1, bottom: 1, left: 1),
                                  child: Text(
                                    widget.textTitle,
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                width: 60,
                                child: TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          // top: 10,
                                          left: 5.0,
                                          bottom: 10.0,
                                          right: 5.0)),
                                  cursorColor: Colors.black,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                  autofocus: true,
                                  onSubmitted: widget.onSubmite,
                                  controller: TextEditingController(
                                    text: widget.textTitle,
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.4, 0.5],
                              colors: [Colors.green, Colors.red[400]],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 60,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       onLongPress: widget.deleteColection,
//       child: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0xFF878686),
//                   blurRadius: 3.0,
//                   spreadRadius: 1.0,
//                   offset: Offset(1, 0.5))
//             ],
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.white,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(left: 5.0, top: 5),
//                 child: Text('Eng', style: TextStyle(fontSize: 10.0)),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 30.0,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10.0),
//                     topRight: Radius.circular(10.0),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       widget.isChecked
//                           ? FittedBox(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   widget.textTitle,
//                                   style: TextStyle(
//                                       fontSize: 35.0, color: Colors.black),
//                                 ),
//                               ),
//                             )
//                           : TextField(
//                               decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       top: 0,
//                                       left: 20.0,
//                                       bottom: 8.0,
//                                       right: 20.0)),
//                               cursorColor: Colors.white,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 35.0,
//                               ),
//                               autofocus: true,
//                               onSubmitted: widget.onSubmite,
//                               controller: TextEditingController(
//                                 text: widget.textTitle,
//                               ),
//                             ),
//                       // Container(
//                       //   padding: EdgeInsets.only(right: 20),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.green,
//                       //     borderRadius: BorderRadius.circular(20),
//                       //   ),
//                       //   height: 60,
//                       //   width: 30,
//                       // ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
