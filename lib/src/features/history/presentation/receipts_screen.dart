import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:medbridge/src/common_widgets/outlined_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/history/data/history_repository.dart';
import 'package:medbridge/src/features/history/presentation/receipt.dart';
import 'package:medbridge/src/features/history/presentation/receipt_shimmer.dart';
import 'package:medbridge/src/features/profile/presentation/current_user_controller.dart';

class Receipts extends ConsumerStatefulWidget {
  const Receipts({super.key});

  @override
  ConsumerState<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends ConsumerState<Receipts> {
  bool isDisabled = false;
  @override
  Widget build(BuildContext context) {
    Map currentUserState = ref.watch(currentUserControllerProvider);
    var getPayments =
        ref.watch(getPatmentsListFutureProvider(currentUserState["patientID"]));

    return getPayments.when(data: (newData) {
      return CustomScrollView(
        slivers: [
          newData.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/images/empty_list_animation.json",
                            width: 230, height: 230, fit: BoxFit.fill),
                        TextCustom(
                          text: "You have no receipts",
                          isBold: true,
                        )
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: newData.length, (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Receipt(
                        time: newData[index]["time"],
                        date: newData[index]["date"],
                        checkmark: true,
                        doctorName: newData[index]["doctor"]["name"],
                        rate: newData[index]["amount"]),
                  );
                })),
        ],
      );
    }, loading: () {
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: 2, (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: ReceiptShimmer());
            }),
          )
        ],
      );
    }, error: (error, stackTrace) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/network_error_animation.json",
                      width: 230, height: 230, fit: BoxFit.fill),
                  TextCustom(
                    text: "Network Error",
                    isBold: true,
                  ),
                  H(h: 20),
                  Padding(
                      padding: const EdgeInsets.only(left: 120, right: 120),
                      child: OutButton(
                          disabled: isDisabled,
                          text: "Retry",
                          onpressed: () async {
                            setState(() {
                              isDisabled = true;
                            });
                            try {
                              // ignore: unused_local_variable
                              List value = await ref.refresh(
                                  getPatmentsListFutureProvider(
                                          currentUserState["patientID"])
                                      .future);

                              setState(() {
                                isDisabled = false;
                              });
                            } catch (error) {
                              setState(() {
                                isDisabled = false;
                              });
                            }
                          }))
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
