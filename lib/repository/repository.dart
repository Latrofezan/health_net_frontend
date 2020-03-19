import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/repository/components/devices_repository.dart';
import 'package:health_net_frontend/repository/components/patients_repository.dart';
import 'package:health_net_frontend/repository/components/users_repository.dart';

class HealthNetRepository{
  final UsersRepository users;
  final PatientsRepository patients;
  final DevicesRepository devices;

  HealthNetRepository._private(this.users, this.patients, this.devices);

  factory HealthNetRepository(String authToken){
    HealthNetRepository._private(UsersRepository(authToken),PatientsRepository(authToken),DevicesRepository(authToken));
  }

  Future<bool> init() async {
    int usersStatus= await users.fetch();
    int patientsStatus= await patients.fetch();
    List<int> devicesStatus;

    if(patientsStatus >= 200&& patientsStatus < 400){
      devicesStatus= await devices.fetch(patients.getAll()).then(
        (checksumMap){
          return checksumMap.values.toList();
        }
      );
    }
    else return false;
    return (
      (usersStatus >= 200&& usersStatus < 400) &&
      (patientsStatus >= 200&& patientsStatus < 400) &&
      devicesStatus.any((element)=>element >= 200&& element < 400));
  }
}