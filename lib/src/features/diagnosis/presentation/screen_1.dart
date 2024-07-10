import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/app_logo.dart';
import 'package:medbridge/src/common_widgets/custom_snackbar.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/diagnosis/data/questions.dart';
import 'package:medbridge/src/features/diagnosis/presentation/diagnosis_controller_provider.dart';
import 'package:medbridge/src/features/diagnosis/presentation/normal_question_container.dart';
import 'package:medbridge/src/features/diagnosis/presentation/screen_2.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Screen1 extends ConsumerStatefulWidget {
  const Screen1({super.key});

  @override
  ConsumerState<Screen1> createState() => _Screen1State();
}

class _Screen1State extends ConsumerState<Screen1> {
  List screen1List = screen_1;

  @override
  Widget build(BuildContext context) {
    var currentDiagnosisState = ref.watch(diagnosisControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 60,
              pinned: true,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              title: AppLogo(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: CircularPercentIndicator(
                    radius: 23.0,
                    lineWidth: 6.5,
                    // animation: true,
                    percent:
                        currentDiagnosisState.getProgress().roundToDouble() /
                            100,
                    center: new Text(
                      "${currentDiagnosisState.getProgress().round().toString()}%",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.5),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color.fromARGB(255, 8, 33, 99),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.maxFinite,
                  color: Color.fromARGB(255, 223, 230, 248),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Center(
                      child: TextCustom(
                        text: "Bipolar dissorder and Depression Test",
                        size: 21,
                        color: Color.fromARGB(255, 8, 33, 99),
                        isBold: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text:
                            "As you answer the questions, consider how they have applied to you over the last 12 months.",
                        size: 14,
                      ),
                      H(h: 10),
                      TextCustom(
                        text: "All fields are required",
                        color: Color.fromARGB(255, 248, 148, 140),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: screen1List.length, (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                  child: NormalQuestionContainer(
                      symptom: screen1List[index]["symptom"],
                      question: screen1List[index]["question"],
                      options: screen1List[index]["options"]),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30, right: 20, left: 20),
                child: MainButton(
                    text: "Next",
                    onpressed: () {
                      if (currentDiagnosisState.getProgress().round() < 35) {
                        CustomSnackBar.show(
                            context, "Missed some fields", true);
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Screen2()));
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
