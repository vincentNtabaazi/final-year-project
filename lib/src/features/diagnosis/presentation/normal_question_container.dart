import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/diagnosis/presentation/diagnosis_controller_provider.dart';

class NormalQuestionContainer extends ConsumerStatefulWidget {
  final String symptom;
  final String question;
  final List<String> options;
  const NormalQuestionContainer(
      {super.key,
      required this.question,
      required this.options,
      required this.symptom});

  @override
  ConsumerState<NormalQuestionContainer> createState() =>
      _NormalQuestionContainerState();
}

class _NormalQuestionContainerState
    extends ConsumerState<NormalQuestionContainer> {
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
            Wrap(
              runSpacing: 10,
              spacing: 10.0,
              children: List<Widget>.generate(
                widget.options.length,
                (int index) {
                  return ChoiceChip(
                    backgroundColor: Color.fromARGB(255, 223, 230, 248),
                    labelStyle: TextStyle(
                        color: _value == index
                            ? Colors.white
                            : Color.fromARGB(255, 8, 33, 99),
                        fontWeight: FontWeight.bold),
                    selectedColor: Color.fromARGB(255, 8, 33, 99),
                    disabledColor: Color.fromARGB(255, 223, 230, 248),
                    labelPadding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(50)),
                    side: BorderSide(color: Color.fromARGB(255, 149, 172, 230)),
                    showCheckmark: false,
                    label: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.options[index].toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                        ref
                            .read(diagnosisControllerProvider.notifier)
                            .updateDiagnosis(
                                selected ? widget.options[_value!] : "",
                                widget.symptom);
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}
