import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsFilterChooseCollection extends StatefulWidget {
  const CollectionsFilterChooseCollection({
    Key key,
    @required this.state,
  }) : super(key: key);

  final TrainingManagerState state;

  @override
  _CollectionsFilterChooseCollectionState createState() =>
      _CollectionsFilterChooseCollectionState();
}

class _CollectionsFilterChooseCollectionState
    extends State<CollectionsFilterChooseCollection> {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Flexible(
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Text('Choose collections',
              style: TextStyle(fontSize: defaultSize * 1.2)),
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
                    content: _buildContent(),
                    actions: _buildAction(),
                  );
                });
          },
        ),
      ),
    );
  }

  List<Widget> _buildAction() {
    return [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'),
      )
    ];
  }

  StatefulBuilder _buildContent() {
    final defaultSize = SizeConfig.defaultSize;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: defaultSize * 30,
          width: SizeConfig.blockSizeHorizontal * 70,
          child: ListView.builder(
            itemExtent: defaultSize * 5,
            itemCount: widget.state.collections.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(widget.state.collections[index].title),
                value: widget.state.selectedCollections
                    .contains(widget.state.collections[index]),
                onChanged: (value) {
                  context.bloc<TrainingManagerBloc>().add(
                      TrainingManagerSelectedCollections(
                          isCollection: value,
                          collection: widget.state.collections[index]));
                  context
                      .bloc<TrainingManagerBloc>()
                      .add(TrainingManagerFiltered());
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
