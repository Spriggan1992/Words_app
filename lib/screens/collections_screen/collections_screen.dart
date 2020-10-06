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
          appBar: BaseAppBar(
            title: Text('collections'),
            appBar: AppBar(),
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
                    ReusableMainButton(
                      titleText: 'Add Collection',
                      textColor: Colors.white,
                      backgroundColor: Theme.of(context).buttonColor,
                      onPressed: () {
                        buildShowGeneralDialog(
                          context,
                        );
                      },
                    )
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
