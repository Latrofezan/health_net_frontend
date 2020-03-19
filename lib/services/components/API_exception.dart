class APIException implements Exception{
  final int statusCode;

  APIException(this.statusCode);
  
  //if the code translation map does not contain a message for the given error, return an empty string.
  String toString()=>_codeTranslation[statusCode]??"";
}

final Map<int,String> _codeTranslation=
{
  400:"Should not be repeated without modification.",
  401:"User Authentication required.",
  403:"Server refused to fulfill the request.",
  404:"Server has not found the required resource.",
  408:"The client did not produce a request within the time that the server was prepared to wait.",
  409:"The request could not be completed due to a conflict with the current state of the resource.",
  410:"The requested resource is no longer available at the server and no forwarding address is known.",
  500:"The server encountered an unexpected condition which prevented it from fulfilling the request.",
  501:"The server does not support the functionality required to fulfill the request.",
  502:"The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.",
  503:"The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.",
};