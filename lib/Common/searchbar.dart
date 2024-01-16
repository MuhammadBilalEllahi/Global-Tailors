import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar(
      {super.key,
      required this.title,
      this.voidCallback,
      this.textEditingController,
      this.trailingWidget});
  final String title;
  final VoidCallback? voidCallback;
  final Widget? trailingWidget;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 10, left: 30, bottom: 10),
      child: SearchBar(
        controller: textEditingController,
        onChanged: (value) {
          voidCallback!.call();
          print(value);
        },
        hintText: title,
        trailing: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: trailingWidget,
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: voidCallback, icon: const Icon(Icons.search)),
        ),
      ),
    );
  }
}
