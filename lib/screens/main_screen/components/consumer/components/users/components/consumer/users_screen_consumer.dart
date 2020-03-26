import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/users_management/bloc/users_bloc.dart';
import 'package:health_net_frontend/components/ui/loading_dialog/loading_dialog.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/ui/app_bar.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/ui/error_screen/user_error.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/ui/user_cards_list/users_card_list.dart';

class UsersScreenConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (BuildContext context, UsersState state) {
        LoadingDialog.hide(context);
        if (state is UsersFetching) {
          LoadingDialog.show(context);
        }
      },
      builder: (BuildContext context, UsersState state) {
        if (state is UsersFetchingFailed)
          return UsersErrorScreen(state.statusCode);

        if (state is UsersFetchingSuccess)
          return Padding(
            padding: EdgeInsets.symmetric(vertical:6),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                UsersAppBar(state.actualUser),
                Expanded(
                    child: Padding(
                  child: BlocProvider.value(
                      value: BlocProvider.of<UsersBloc>(context),
                      child: UsersCardList(state.users)),
                  padding: EdgeInsets.all(8),
                ))
              ]));

        return Container(height: 0.0, width: 0.0);
      },
    );
  }
}
