import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoDetilSetoran extends StatelessWidget {
  const InfoDetilSetoran({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 1))
              ]),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


        // TextButton(
        //   onPressed: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => Dialog(
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             const Text('This is a typical dialog.'),
        //             const SizedBox(height: 15),
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //               child: const Text('Close'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   child: const Text('Show Dialog'),
        // ),
        // const SizedBox(height: 10),
        // TextButton(
        //   onPressed: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => Dialog.fullscreen(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           const Text('This is a fullscreen dialog.'),
        //           const SizedBox(height: 15),
        //           TextButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //             },
        //             child: const Text('Close'),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   child: const Text('Show Fullscreen Dialog'),
        // ),
      ],
    );
  }
}

class InfoDaftarSetoran extends StatelessWidget {
  const InfoDaftarSetoran({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                  offset: Offset(0, 1))
            ],
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoPengaturan extends StatelessWidget {
  const InfoPengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 1))
              ]),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
