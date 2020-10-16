import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/config/size_config.dart';
import 'package:words_app/widgets/widgets.dart';
import 'widgets/widgets.dart';

/// [CollectionsScreen] responsible for showing all collections  created by user
/// it is separated into components for better modularity
class CollectionsScreen extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: BaseAppBar(
            screenDefiner: ScreenDefiner.collections,
            title: Text('collections'),
            appBar: AppBar(),
          ),
          bottomSheet: BaseBottomAppbar(
            screenDefiner: ScreenDefiner.collections,
            add: () => _buildShowGeneralDialog(context),
            goToTrainings: () {
              Navigator.pushNamed(
                context,
                TrainingManager.id,
              );
              context.bloc<TrainingManagerBloc>().add(TrainingManagerLoaded());
            },
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

  Future _buildShowGeneralDialog(BuildContext context) {
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
