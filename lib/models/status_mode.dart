class StatusModel{

      String docid;
      String imageUrl;
      String title;
      String message;
      int count;

      StatusModel( {this.docid , this.imageUrl, this.title, this.message , this.count});
      toMap(){
        Map<String , dynamic> map = Map();
        map['docid'] = docid;
        map['imageUrl'] = imageUrl;
        map['title'] = title;
        map['message'] = message;
        map['count'] = count;
        return map;
      }
}