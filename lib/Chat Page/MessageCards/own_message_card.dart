import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.text, required this.name, required this.timestamp});

  final String text;
  final String name;
 final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
print("---------------${timestamp.toDate().hour}:${timestamp.toDate().minute}");
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child:  GestureDetector(
          onLongPress:(){
             _copyToClipboard(context,text);
          },
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color:  Colors.orangeAccent.shade100.withOpacity(.6),
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 60, top :5, bottom: 20),
                      child: Text(text,
                      style: const TextStyle(
                        fontSize: 15
                      ),),
                    ),
                     Positioned(
                      bottom: 4,
                      right: 10, 
                      child: Row(
                        children: [
                          Text("${timestamp.toDate().hour}:${timestamp.toDate().minute}", 
                        style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                           ),
                                ),
                      const SizedBox(width: 5,),
                
                      const Icon(Icons.done_all, size: 20 )
                      
                      ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }
}
