import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: const Color(0XFFF2F2F2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CustomIconButton(
                  text: 'Add Note',
                  iconData: CupertinoIcons.plus_rectangle_on_rectangle,
                  onPressed: () {},
                ),
                const SizedBox(width: 8.0),
                CustomIconButton(
                  text: 'Save Note',
                  iconData: Icons.save_as_outlined,
                  onPressed: () {},
                ),
                const SizedBox(width: 8.0),
                CustomIconButton(
                  text: 'Download Note',
                  iconData: Icons.download_outlined,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: const Color(0XFFF2F2F2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Notes(3) Available'),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(5, (index) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4.0),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          CupertinoIcons.play,
                          color: Colors.blueGrey,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  '0:35 - 1:43',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(4.0),
                                  style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(
                                    Icons.edit_note,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(4.0),
                                  style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.blueGrey,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Your thoughts',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const Divider(),
                            Text(
                              'Classical economists that the economy is always '
                              'capable of achieving the natural level of real GDP '
                              'or output, which is the level of real GDP that is '
                              'obtained when the economy\'s resources are fully employed.',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
