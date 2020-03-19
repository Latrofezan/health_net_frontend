class APIInterfaces{
  static final String _url="healthnet-api-gateway.herokuapp.com";

  static final Map<String,String> _interfaces={
    "authentication":_url+"/account/token/email",
    "patients":_url+"/patients",
    "devices":_url+"/devices",
    "users":_url+"/users",
  };

  static String getAuthenticationURl()=>_interfaces["authentication"];
  static String getPatientsURl()=>_interfaces["patients"];
  static String getDevicesURl()=>_interfaces["devices"];
  static String geUsersURl()=>_interfaces["users"];
}