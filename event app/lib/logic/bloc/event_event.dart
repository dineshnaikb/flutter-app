part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventInitial extends EventEvent {
  String photo_url;
  String uid;
  EventInitial({
    required this.photo_url,
    required this.uid,
  });
}

class EventEditInitial extends EventEvent {
  EventState eventToEdit;

  EventEditInitial({required this.eventToEdit});
}

class EventAddMainImage extends EventEvent {
  String path;
  EventAddMainImage({
    required this.path,
  });
}

class EventAddImage1 extends EventEvent {
  String path;
  EventAddImage1({
    required this.path,
  });
}

class EventAddImage2 extends EventEvent {
  String path;
  EventAddImage2({
    required this.path,
  });
}

class EventAddImage3 extends EventEvent {
  String path;
  EventAddImage3({
    required this.path,
  });
}

class EventAddtitle extends EventEvent {
  String title;
  EventAddtitle({
    required this.title,
  });
}

class EventAddPlace extends EventEvent {
  String place;
  EventAddPlace({
    required this.place,
  });
}

class EventAddVideo extends EventEvent {
  String link;
  EventAddVideo({
    required this.link,
  });
}

class EventAddOfferingOption extends EventEvent {
  String option;
  EventAddOfferingOption({
    required this.option,
  });
}

class EventAddType extends EventEvent {
  List<String> types;
  EventAddType({
    required this.types,
  });
}

class EventToggleUserInInvitedList extends EventEvent {
  String user;
  EventToggleUserInInvitedList({
    required this.user,
  });
}

class EventToggleUserInCoshareList extends EventEvent {
  String user;
  EventToggleUserInCoshareList({
    required this.user,
  });
}

class EventAddFromTime extends EventEvent {
  String time;
  EventAddFromTime({
    required this.time,
  });
}

class EventAddToTime extends EventEvent {
  String time;
  EventAddToTime({
    required this.time,
  });
}

class EventAddFoodAndBeverage extends EventEvent {
  String text;
  EventAddFoodAndBeverage({
    required this.text,
  });
}

class EventAddEventDate extends EventEvent {
  String date;
  EventAddEventDate({
    required this.date,
  });
}

class EventAddFromAge extends EventEvent {
  String age;
  EventAddFromAge({
    required this.age,
  });
}

class EventAddToAge extends EventEvent {
  String age;
  EventAddToAge({
    required this.age,
  });
}

class EventAddComments extends EventEvent {
  String comment;
  EventAddComments({
    required this.comment,
  });
}

class EventTogglePaidEvent extends EventEvent {
  bool enabled;
  EventTogglePaidEvent({
    required this.enabled,
  });
}

class EventTogglePrivateEvent extends EventEvent {
  bool enabled;
  EventTogglePrivateEvent({
    required this.enabled,
  });
}

class EventAddMalePrice extends EventEvent {
  String price;
  EventAddMalePrice({
    required this.price,
  });
}

class EventAddFemalePrice extends EventEvent {
  String price;
  EventAddFemalePrice({
    required this.price,
  });
}

class EventAddMaleNo extends EventEvent {
  String no;
  EventAddMaleNo({
    required this.no,
  });
}

class EventAddFemaleNo extends EventEvent {
  String no;
  EventAddFemaleNo({
    required this.no,
  });
}

class EventToggleVirtualEvent extends EventEvent {
  bool enabled;
  EventToggleVirtualEvent({
    required this.enabled,
  });
}

class EventSubmitted extends EventEvent {}

class EventComplete extends EventEvent {}
