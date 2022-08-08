import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';
import 'package:events/logic/cubit/switch_cubit.dart';
import 'package:events/ui/widgets/feed_item.dart';
import 'package:flutter/material.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    context.read<EventDisplayBloc>().add(EventDiplayGetAllEventsInitial());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/message_screen');
                  },
                  child: SvgPicture.asset(
                    'assets/inbox.svg',
                    color: Theme.of(context).appBarIconColor,
                  )))
        ],
        title: Image.asset(
          Theme.of(context).logo,
          width: 22.0.w,
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset('assets/Notifications.svg',
                  color: Theme.of(context).appBarIconColor,
                  semanticsLabel: 'A red up arrow'),
            )
            // const Icon(FontAwesomeIcons.bell)
            ),
        centerTitle: true,
      ),
      body: BlocProvider<SwitchCubit>(
        create: (context) => SwitchCubit(),
        child: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                child: EventTypeSwitch()),
            SizedBox(
              height: 2.0.h,
            ),
            Builder(builder: (context) {
              List<EventState> events = [];

              EventDisplayType eventDisplayType =
                  context.watch<EventDisplayBloc>().state.eventDisplayType;

              int counter = context.watch<SwitchCubit>().state.counter;
              int counter1 = context.watch<SwitchCubit>().state.counter;

              if (counter == 0) {
                if (counter1 == 0) {
                  events =
                      context.watch<EventDisplayBloc>().state.virtual_events;
                } else {
                  events = context.watch<EventDisplayBloc>().state.all_events;
                }
              } else if (counter == 1) {
                print("xyz");
                events = context.watch<EventDisplayBloc>().state.virtual_events;
              } else if (counter == 2) {
                events =
                    context.watch<EventDisplayBloc>().state.recommended_events;
              }

              if (events.isEmpty) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Flexible(
                  child: Container(
                    child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return FeedItem(
                            event: events[index],
                            allEvents: events,
                          );
                        }),
                  ),
                );
              }
            }),
            SizedBox(
              height: 5.0.h,
            ),
          ],
        ),
      ),
    );
  }
}

class EventTypeSwitch extends StatefulWidget {
  const EventTypeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<EventTypeSwitch> createState() => _EventTypeSwitchState();
}

class _EventTypeSwitchState extends State<EventTypeSwitch> {
  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = _isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleSwitch(
          minWidth: 35.0.w,
          cornerRadius: 100.0,
          fontSize: 14.0,
          initialLabelIndex: context.read<SwitchCubit>().state.counter,
          radiusStyle: true,
          activeBgColor: [Theme.of(context).activeColor],
          activeFgColor: Theme.of(context).switchColor,
          inactiveBgColor: Theme.of(context).toggleColor,
          inactiveFgColor: Theme.of(context).textPrimaryColor,
          customTextStyles: [
            context.watch<SwitchCubit>().state.counter == 0
                ? GoogleFonts.raleway(
                    color: Theme.of(context).switchColor,
                    fontWeight: FontWeight.w700)
                : GoogleFonts.raleway(
                    color: Theme.of(context).textPrimaryColor,
                    fontWeight: FontWeight.w300),
            context.watch<SwitchCubit>().state.counter == 1
                ? GoogleFonts.raleway(
                    color: Theme.of(context).switchColor,
                    fontWeight: FontWeight.w700)
                : GoogleFonts.raleway(
                    color: Theme.of(context).textPrimaryColor,
                    fontWeight: FontWeight.w300),
            context.watch<SwitchCubit>().state.counter == 2
                ? GoogleFonts.raleway(
                    color: Theme.of(context).switchColor,
                    fontWeight: FontWeight.w700)
                : GoogleFonts.raleway(
                    color: Theme.of(context).textPrimaryColor,
                    fontWeight: FontWeight.w300),
          ],
          totalSwitches: 3,
          // labels: ['All events', 'Virtual', 'Recommneded'],
          labels: ['All events', 'LoopedIn', 'Recommended'],
          onToggle: (index) {
            if (index == 0) {
              _isVisible = true;
              context.read<EventDisplayBloc>().add(EventDiplayGetAllEvents());
            }
            if (index == 1) {
              _isVisible = false;
              context
                  .read<EventDisplayBloc>()
                  .add(EventDiplayGetVirtualEvents());
            }
            if (index == 2) {
              _isVisible = false;
              context
                  .read<EventDisplayBloc>()
                  .add(EventDiplayGetRecommededEvents());
            }
            context.read<SwitchCubit>().change(index);
          },
        ),
        SizedBox(
          height: 36,
        ),
        Visibility(
          visible: _isVisible,
          child: ToggleSwitch(
              minWidth: 45.0.w,
              cornerRadius: 100.0,
              fontSize: 14.0,
              initialLabelIndex: context.read<SwitchCubit>().state.counter,
              radiusStyle: true,
              activeBgColor: [Theme.of(context).activeColor],
              activeFgColor: Theme.of(context).switchColor,
              inactiveBgColor: Theme.of(context).toggleColor,
              inactiveFgColor: Theme.of(context).textPrimaryColor,
              customTextStyles: [
                context.watch<SwitchCubit>().state.counter == 0
                    ? GoogleFonts.raleway(
                        color: Theme.of(context).switchColor,
                        fontWeight: FontWeight.w700)
                    : GoogleFonts.raleway(
                        color: Theme.of(context).textPrimaryColor,
                        fontWeight: FontWeight.w300),
                context.watch<SwitchCubit>().state.counter == 1
                    ? GoogleFonts.raleway(
                        color: Theme.of(context).switchColor,
                        fontWeight: FontWeight.w700)
                    : GoogleFonts.raleway(
                        color: Theme.of(context).textPrimaryColor,
                        fontWeight: FontWeight.w300),
              ],
              totalSwitches: 2,
              labels: ['Upcoming Events', 'Pending Events '],
              onToggle: (index) {
                if (index == 0) {
                  _isVisible = true;
                  context
                      .read<EventDisplayBloc>()
                      .add(EventDiplayGetUpcommingAndPending());
                }
                if (index == 1) {
                  _isVisible = false;
                  context
                      .read<EventDisplayBloc>()
                      .add(EventDiplayGetUpcommingAndPending());
                }
              }),
        )
      ],
    );
  }
}
