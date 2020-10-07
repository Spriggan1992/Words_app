import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/widgets/widgets.dart';
import 'widgets/collection_widgets.dart';

/// [CollectionsScreen] responsible for showing all collections  created by user
/// it is separated into components for better modularity
class CollectionsScreen extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, CollectionsScreen.id,
              ModalRoute.withName(CollectionsScreen.id));
          context.bloc<CollectionsBloc>().add(CollectionsSetToFalse());
          return;
        },
        child: Scaffold(
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: BaseAppBar(
            title: Text('collections'),
            appBar: AppBar(),
          ),
          // bottomNavigationBar: BaseBottomAppBar(
          //   child1: ReusableBottomIconBtn(
          //     color: Colors.white,
          //     icons: Icons.arrow_back_ios,
          //     onPress: () {},
          //   ),
          //   child2: ReusableBottomIconBtn(
          //     color: Colors.white,
          //     icons: Icons.home,
          //     onPress: () {},
          //   ),
          // ),

          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.,
          // floatingActionButton: ReusableFloatActionButton(),
          bottomSheet: Container(
            height: 60,

            color: Theme.of(context).scaffoldBackgroundColor,
            // color: Colors.white,
            // color: Colors.transparent,
            child: Stack(
              alignment: AlignmentDirectional.center,
              overflow: Overflow.visible,
              // alignment: Alignment.bottomLeft,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    SizedBox(width: 10),
                    ReusableBottomIconBtn(
                      color: Theme.of(context).accentColor,
                      icons: Icons.arrow_back_ios,
                      onPress: () {},
                    ),
                    SizedBox(width: 20),
                    ReusableBottomIconBtn(
                      color: Theme.of(context).accentColor,
                      icons: Icons.home,
                      onPress: () {},
                    ),
                  ],
                )),
                Positioned(
                  top: -10,
                  child: ReusableFloatActionButton(
                      onPressed: () => buildShowGeneralDialog(context)),
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ReusableBottomIconBtn(
                      color: Theme.of(context).accentColor,
                      icons: Icons.fitness_center,
                      onPress: () {},
                    ),
                    SizedBox(width: 20),
                    ReusableBottomIconBtn(
                      color: Theme.of(context).accentColor,
                      icons: Icons.settings,
                      onPress: () {},
                    ),
                    SizedBox(width: 10),
                  ],
                )),
              ],
            ),
          ),
          body: BlocBuilder<CollectionsBloc, CollectionsState>(
            builder: (context, state) {
              if (state is CollectionsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CollectionsSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Body(
                        collections: state.collections,
                      ),
                    ),

                    // ReusableMainButton(
                    //   titleText: 'Add Collection',
                    //   textColor: Colors.white,
                    //   backgroundColor: Theme.of(context).buttonColor,
                    //   onPressed: () {
                    //     buildShowGeneralDialog(
                    //       context,
                    //     );
                    //   },
                    // )
                  ],
                );
              } else {
                return Text('Somthing went wrong...');
              }
            },
          ),
        ),
      ),
    );
  }

  Future buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Color(0xff906c7a),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Color(0xffEAE2DA),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return DialogAddCollection();
                },
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      },
    );
  }
}
