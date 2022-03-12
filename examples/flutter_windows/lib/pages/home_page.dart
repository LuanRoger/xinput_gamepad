import 'package:flutter/material.dart';
import 'package:flutter_windows/pages/widgets/controller_information_containter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final int flexFactorContainer = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
              flex: flexFactorContainer,
              child: ControllerInformationContainter(
                color: const Color.fromRGBO(255, 179, 169, 1),
                index: 0,
              )),
          const Spacer(),
          Expanded(
              flex: flexFactorContainer,
              child: ControllerInformationContainter(
                color: const Color.fromRGBO(173, 198, 255, 1),
                index: 1,
              )),
          const Spacer(),
          Expanded(
              flex: flexFactorContainer,
              child: ControllerInformationContainter(
                color: const Color.fromRGBO(97, 224, 90, 1),
                index: 2,
              )),
          const Spacer(),
          Expanded(
              flex: flexFactorContainer,
              child: ControllerInformationContainter(
                color: const Color.fromRGBO(255, 185, 79, 1),
                index: 3,
              ))
        ]),
      ),
    );
  }
}
