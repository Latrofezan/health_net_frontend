import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/repository/components/patients_repository.dart';
import 'components/flush_bars/error_flushbar.dart';
import 'components/flush_bars/success_flushbar.dart';
import 'components/patient_registration_form.dart';

class PatientsRegistrationDialog {
  final BuildContext _context;
  final PatientsRepository _repository;

  PatientsRegistrationDialog(this._context, this._repository);


   Future<void> show() async {
    Patient result = await showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: PatientRegistrationForm(height: 220, width: 220,),
            ));

      if(result!=null){
              int code=await _repository.add(result);
              await _patientsResultEvaluation(_context, result, code, _repository);
            }
  }

  
  _patientsResultEvaluation(BuildContext context, Patient patient, int statusCode, PatientsRepository repository) async {
      if(statusCode >= 200 && statusCode < 400){
          SuccessFlushBar(patient, context).show();
      }
      else
      {
        Patient retryPatient = await ErrorFlushBar(patient, context, statusCode).show();
        if(retryPatient!=null)
        {
          int retryResult = await repository.add(retryPatient);
          await _patientsResultEvaluation(context, retryPatient, retryResult, repository);
        }
      }
  }
}
