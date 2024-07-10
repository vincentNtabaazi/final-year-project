import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/app_logo.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/common_widgets/outlined_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/authentication/presentation/login_screen.dart';
import 'package:medbridge/src/features/diagnosis/presentation/diagnosis_controller_provider.dart';
import 'package:medbridge/src/features/diagnosis/presentation/screen_1.dart';

class Results extends ConsumerStatefulWidget {
  final String results;
  const Results({super.key, required this.results});

  @override
  ConsumerState<Results> createState() => _ResultsState();
}

class _ResultsState extends ConsumerState<Results> {
  @override
  Widget build(BuildContext context) {
    // var currentDiagnosisState = ref.watch(diagnosisControllerProvider);
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: AppLogo(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 8, 33, 99),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: "Your Results",
                        color: Colors.white,
                      ),
                      H(h: 15),
                      SizedBox(
                        width: 300,
                        child: TextCustom(
                          text: widget.results,
                          color: Colors.white,
                          isBold: true,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 230, 248),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Color.fromARGB(255, 149, 172, 230))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: Column(
                    children: [
                      TextCustom(
                        text:
                            "Your test result suggests symptoms consistent with ${widget.results}",
                        isBold: true,
                      ),
                      H(h: 10),
                      TextCustom(
                        text:
                            "This result is not a diagnosis. A doctor or therapist can help you get a diagnosis and treatment.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: Column(
                children: [
                  MainButton(
                      text: "Talk To a Professional",
                      onpressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      }),
                  H(h: 15),
                  OutButton(
                      text: "Login To Save Results",
                      onpressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginScreen(results: widget.results,)));
                      }),
                  H(h: 15),
                  OutButton(
                      text: "Take Another Test",
                      onpressed: () {
                        ref
                            .read(diagnosisControllerProvider.notifier)
                            .killDiagnosisState();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Screen1()),
                          (Route<dynamic> route) =>
                              false, // Remove all routes from the stack
                        );
                      })
                ],
              ),
            )
          ],
        ));
  }
}
