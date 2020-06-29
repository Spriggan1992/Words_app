import 'package:flutter/material.dart';

enum DropItemItems { changeName, delete, changeColor }

class BoxCollection extends StatefulWidget {
  BoxCollection(
      {this.textTitle,
      this.chooseOptions,
      this.onTap,
      this.isCheckedTextEdit,
      this.isCheckedOptionsMenu,
      this.onSubmite,
      this.onChanged,
      this.editText,
      this.deleteCollection});

  final String textTitle;
  final Function chooseOptions;
  final Function onTap;
  final bool isCheckedTextEdit;
  final bool isCheckedOptionsMenu;
  final Function onSubmite;
  final Function onChanged;
  final Function editText;
  final Function deleteCollection;

  @override
  _BoxCollectionState createState() => _BoxCollectionState();
}

class _BoxCollectionState extends State<BoxCollection>
    with SingleTickerProviderStateMixin {
  TextEditingController editingController;
  AnimationController controller;
  Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    controller.forward();

    // controller.addListener(() {
    //   setState(() {});
    // });

    offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: widget.onTap,
      onLongPress: widget.chooseOptions,

// Here is check if Show Collection or OptionsMenu
      child: !widget.isCheckedOptionsMenu
          ? SlideTransition(
              position: offsetAnimation,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF878686),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                        offset: Offset(1, 3))
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: widget.isCheckedOptionsMenu
                      ? Color(0xFFF8B6b6)
                      : Colors.grey[200],
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
//Show Text.
                            widget.isCheckedTextEdit
                                ? Expanded(
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1,
                                            right: 1,
                                            bottom: 1,
                                            left: 1),
                                        child: Text(
                                          widget.textTitle,
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
//Show Text field(Chacnge collections name)
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
// Indicator amount of words in collection
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.3, 0.7],
                                      colors: [Colors.green, Colors.red[400]],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 60,
                                  width: 30,
                                  child: Center(
                                      child: Text('5',
                                          style: TextStyle(fontSize: 17)))),
                            ),
                          ],
                        ),
                      ),
                      //OptionsMenu
                    )
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF878686),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                      offset: Offset(1, 3))
                ],
                borderRadius: BorderRadius.circular(10.0),
                color: widget.isCheckedOptionsMenu
                    ? Color(0xFFF8B6b6).withOpacity(controller.value)
                    : Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.editText,
                    child: Container(
                      child: Icon(Icons.edit),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.deleteCollection,
                    child: Container(
                      child: Icon(Icons.delete_outline),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // onTap: widget.onTap,
//       onLongPress: widget.chooseOptions,
//       onHorizontalDragEnd: widget.chooseOptions,

// // Here is check if Show Collection or OptionsMenu
//       child: !widget.isCheckedOptionsMenu
//           ? Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color(0xFF878686),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                       offset: Offset(1, 3))
//                 ],
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: widget.isCheckedOptionsMenu
//                     ? Color(0xFFF8B6b6)
//                     : Colors.grey[200],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.only(
//                       left: 5.0,
//                       top: 5,
//                     ),
//                     child: Text('Eng', style: TextStyle(fontSize: 10.0)),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: 30.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         topRight: Radius.circular(10.0),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
// //Show Text.
//                           widget.isCheckedTextEdit
//                               ? Expanded(
//                                   child: FittedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 1, right: 1, bottom: 1, left: 1),
//                                       child: Text(
//                                         widget.textTitle,
//                                         style: TextStyle(
//                                             fontSize: 25.0,
//                                             color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 )
// //Show Text field(Chacnge collections name)
//                               : Expanded(
//                                   child: Container(
//                                     width: 60,
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                           contentPadding: EdgeInsets.only(
//                                               // top: 10,
//                                               left: 5.0,
//                                               bottom: 10.0,
//                                               right: 5.0)),
//                                       cursorColor: Colors.black,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                       ),
//                                       autofocus: true,
//                                       onSubmitted: widget.onSubmite,
//                                       controller: TextEditingController(
//                                         text: widget.textTitle,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
// // Indicator amount of words in collection
//                           Padding(
//                             padding: EdgeInsets.only(left: 5),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.bottomCenter,
//                                     end: Alignment.topCenter,
//                                     stops: [0.3, 0.7],
//                                     colors: [Colors.green, Colors.red[400]],
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 height: 60,
//                                 width: 30,
//                                 child: Center(
//                                     child: Text('5',
//                                         style: TextStyle(fontSize: 17)))),
//                           ),
//                         ],
//                       ),
//                     ),
//                     //OptionsMenu
//                   )
//                 ],
//               ),
//             )
//           : Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color(0xFF878686),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                       offset: Offset(1, 3))
//                 ],
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: widget.isCheckedOptionsMenu
//                     ? Color(0xFFF8B6b6).withOpacity(controller.value)
//                     : Colors.grey[200],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: widget.editText,
//                     child: Container(
//                       child: Icon(Icons.edit),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: widget.deleteCollection,
//                     child: Container(
//                       child: Icon(Icons.delete_outline),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

//  AnimationController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       duration: Duration(seconds: 10),
//       vsync: this,
//     );
//     controller.forward();

//     controller.addListener(() {
//       setState(() {});
//     });
//   }
