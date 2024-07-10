import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/diagnosis/presentation/diagnosis_controller_provider.dart';

class ScaledQuestionContainer extends ConsumerStatefulWidget {
  final String question;
  final String symptom;
  const ScaledQuestionContainer({
    super.key,
    required this.question,
    required this.symptom
  });

  @override
  ConsumerState<ScaledQuestionContainer> createState() =>
      _ScaledQuestionContainerState();
}

class _ScaledQuestionContainerState
    extends ConsumerState<ScaledQuestionContainer> {
  int? _value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextCustom(
              text: widget.question,
              size: 17,
            ),
            H(h: 15),
            SizedBox(
              child: Column(
                children: [
                  Wrap(
                    spacing: 20.0,
                    children: List<Widget>.generate(
                      5,
                      (int index) {
                        return ChoiceChip(
                          backgroundColor: Color.fromARGB(255, 223, 230, 248),
                          selectedColor: Color.fromARGB(255, 8, 33, 99),
                          disabledColor: Color.fromARGB(255, 223, 230, 248),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(50)),
                          side: BorderSide(
                              color: Color.fromARGB(255, 149, 172, 230)),
                          showCheckmark: false,
                          label: Text(
                            "",
                          ),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                              ref
                                  .read(diagnosisControllerProvider.notifier)
                                  .updateDiagnosis(
                                      selected
                                          ? "${((index + 1) * 2).toString()} From 10"
                                          : "",
                                      widget.symptom);
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                  Container(
                    width: 320,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(
                            text: "Low",
                            size: 13,
                          ),
                          TextCustom(
                            text: "High",
                            size: 13,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


