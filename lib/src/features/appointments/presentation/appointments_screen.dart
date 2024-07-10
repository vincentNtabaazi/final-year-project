import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:medbridge/src/common_widgets/outlined_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/appointments/data/appointments_repository.dart';
import 'package:medbridge/src/features/appointments/presentation/appointment_card.dart';
import 'package:medbridge/src/features/appointments/presentation/appointment_shimmer.dart';
import 'package:medbridge/src/features/appointments/presentation/appointments_controller.dart';
import 'package:medbridge/src/features/landingPage/landing_page.dart';
import 'package:medbridge/src/features/profile/presentation/current_user_controller.dart';
import 'package:medbridge/src/features/profile/presentation/profile_widget.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    Map currentUser = ref.watch(currentUserControllerProvider);

    List currentAppointments = ref.watch(appointmentsControllerProvider);
    var asyncValue =
        ref.watch(getappointmentsListFutureProvider(currentUser["patientID"]));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            // ignore: unused_result
            await ref.refresh(
                getappointmentsListFutureProvider(currentUser["patientID"])
                    .future);
          } catch (error) {
          //    CustomSnackBar.show(
          // context, "No internet connection", true);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 60,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              title: TextCustom(
                text: "Appointments",
                isBold: true,
                size: 19,
                color: Color.fromARGB(255, 8, 33, 99),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 110,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Container(
                                    height: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 8, 33, 99),
                                            child: TextCustom(
                                              text: currentUser["name"][0]
                                                  .toString()
                                                  .toUpperCase(),
                                              color: Colors.white,
                                              isBold: true,
                                            ),
                                            radius: 20,
                                          ),
                                          W(w: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextCustom(
                                                size: 18,
                                                text: currentUser["name"],
                                                isBold: true,
                                              ),
                                              TextCustom(
                                                size: 15,
                                                text: currentUser["email"],
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: InkWell(
                                              onTap: () {
                                                
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Landing()),
                                                  (Route<dynamic> route) =>
                                                      false, // Remove all routes from the stack
                                                );
                                              },
                                              child: Icon(
                                                Icons.logout,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ProfileWidget(
                      firstLetter:
                          currentUser["name"][0].toString().toUpperCase(),
                    ),
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                child: TextCustom(
                  text: "All pending appointments",
                  color: Color.fromARGB(255, 122, 122, 122),
                ),
              ),
            ),
            asyncValue.when(
              data: (newData) {
                return currentAppointments.isEmpty
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                  "assets/images/empty_list_animation.json",
                                  width: 230,
                                  height: 230,
                                  fit: BoxFit.fill),
                              TextCustom(
                                text: "You have no appointments",
                                isBold: true,
                              )
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: currentAppointments.length,
                            (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: AppointmentCard(
                              doctorName:
                                  "Dr ${currentAppointments[index]["doctor"]["name"]}",
                              date: currentAppointments[index]["date"],
                              time: currentAppointments[index]["time"],
                            ),
                          );
                        }),
                      );
              },
              error: (error, stackTrace) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                            "assets/images/network_error_animation.json",
                            width: 230,
                            height: 230,
                            fit: BoxFit.fill),
                        TextCustom(
                          text: "Network Error",
                          isBold: true,
                        ),
                        H(h: 20),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 120, right: 120),
                            child: OutButton(
                                disabled: isDisabled,
                                text: "Retry",
                                onpressed: () async {
                                  setState(() {
                                    isDisabled = true;
                                  });
                                  try {
                                    bool value = await ref.refresh(
                                        getappointmentsListFutureProvider(
                                                currentUser["patientID"])
                                            .future);

                                    if (value) {
                                      setState(() {
                                        isDisabled = false;
                                      });
                                    }
                                  } catch (error) {
                                    setState(() {
                                      isDisabled = false;
                                    });
                                  }
                                }))
                      ],
                    ),
                  ),
                );
              },
              loading: () {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 3,
                      (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: AppointmentShimmer());
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
