class User{
String useremail;
String username;
String userpwd;

 User(this.useremail,  this.username,  this.userpwd);

 Map<String, dynamic> toJson() => {
  'useremail' : useremail,
  'username' : username,
  'userpwd' : userpwd,
 };

}

class Useremail{
  String useremail;

  Useremail(this.useremail);

  Map<String, dynamic> toJson() => {
    'useremail2' : useremail
  };
}