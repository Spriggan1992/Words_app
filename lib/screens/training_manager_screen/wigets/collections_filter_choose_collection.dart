import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsFilterChooseCollection extends StatefulWidget {
  const CollectionsFilterChooseCollection({
    Key key,
    @required this.defaultSize,
    @required this.state,
  }) : super(key: key);

  final double defaultSize;
  final TrainingsState state;

  @override
  _CollectionsFilterChooseCollectionState createState() =>
      _CollectionsFilterChooseCollectionState();
}

class _CollectionsFilterChooseCollectionState
    extends State<CollectionsFilterChooseCollection> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Text('Choose collections', style: TextStyle(fontSize: 12)),
          trailing: Icon(Icons.arrow_drop_down),
          visualDensity: VisualDensity.compact,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Select Colletions',
                      textAlign: TextAlign.center,
                    ),
                    content: buildContent(),
                    actions: buildAction(),
                  );
                });
          },
        ),
      ),
    );
  }

  List<Widget> buildAction() {
    return [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'),
      )
    ];
  }

  StatefulBuilder buildContent() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: widget.defaultSize * 30,
          width: SizeConfig.blockSizeHorizontal * 70,
          child: ListView.builder(
            itemExtent: widget.defaultSize * 5,
            itemCount: widget.state.collections.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(widget.state.collections[index].title),
                value: widget.state.selectedCollections
                    .contains(widget.state.collections[index]),
                onChanged: (value) {
                  context.bloc<TrainingsBloc>().add(
                      TrainingsSelectedCollections(
                          isCollection: value,
                          collection: widget.state.collections[index]));
                  context.bloc<TrainingsBloc>().add(TrainingsFiltered());
                  setState(() {});
                },
              );
            },
          ),
        );
      },
    );
  }
}
