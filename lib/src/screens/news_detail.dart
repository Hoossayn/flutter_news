import 'package:flutter/material.dart';
import '../blocs/comment_provider.dart';
import '../models/item_model.dart';
import 'dart:async';
import '../widgets/comment.dart';


class NewsDetail extends StatelessWidget {
  final int itemId;
  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {

    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
        if(!snapshot.hasData){
          return Text('loading');
        }

        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData){
              return Text('loading');
            }
            return buildListOfComment(itemSnapshot.data, snapshot.data);
            },
        );
      },
    );
  }

  Widget buildListOfComment(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildDetailTitle(item));
    final commentsList = item.kids.map((commentKidId){
      return Comment(itemId: commentKidId, itemMap: itemMap,depth: 0);
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children:  children,
    );
  }

  Widget buildDetailTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,

        ),
      ),
    );
  }


}
