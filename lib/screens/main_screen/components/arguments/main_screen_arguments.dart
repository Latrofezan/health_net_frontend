import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/repository/repository.dart';

class MainScreenArguments{
  final HealthNetRepository repository;
  final String email;

  MainScreenArguments(this.repository, this.email);
}