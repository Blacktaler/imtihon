class Information{
  Information({this.postID,this.id,this.name,this.email,this.body});
  int? postID;
  int? id;
  String? name;
  String? email;
  String? body;

  factory Information.fromJson(Map<String,dynamic> json)=>Information(
    postID: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body:  json["body"]
  );


}