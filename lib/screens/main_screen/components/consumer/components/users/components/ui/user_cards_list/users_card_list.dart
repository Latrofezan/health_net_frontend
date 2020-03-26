import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/users_management/bloc/users_bloc.dart';
import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/ui/user_card/user_card.dart';

class UsersCardList extends StatelessWidget {
  final List<User> users;

  const UsersCardList(this.users, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return UserCard(users.elementAt(index));
          }, childCount: users.length))
        ]),
        onRefresh: () async => BlocProvider.of<UsersBloc>(context)
            .add(UsersFetchingRequired(true)));
  }
}
