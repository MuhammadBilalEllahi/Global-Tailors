class ChatModel{
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  bool select = false;
  int id;

  String status;

  ChatModel(
    { this.name='', this.icon='', this.isGroup=false, this.time="", this.currentMessage='', this.status='',  this.select = false , this.id = -1}
    );


}