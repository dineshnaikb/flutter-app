part of 'event_bloc.dart';

class EventState {
  String img1;
  String img2;
  String img3;
  String img4;
  String title;
  String food_bev;
  String place;
  String video_url;
  String offering_option;
  List<String> type;
  Map event_map;
  String from_time;
  String to_time;
  String event_tags;
  String from_age;
  String to_age;
  String comments;
  bool paid_event;
  String male_price;
  String female_price;
  String created_date;
  String event_date;
  String female_no;
  String male_no;
  bool virtual_event;
  String uid;
  String photo_url;
  String total_ticket_volume;
  String Request_Status;
  List<String> invitedFriends;
  List<String> coShareList;
  bool isCurrUserEvent;
  bool isCurrEvent;

  FormSubmissionStatus formSubmissionStatus;
  EventState({
    this.img1 = '',
    this.img2 = '',
    this.img3 = '',
    this.img4 = '',
    this.title = '',
    this.food_bev = '',
    this.place = '',
    this.video_url = '',
    this.offering_option = '',
    this.type = const [],
    this.event_map = const {},
    this.from_time = 'From',
    this.to_time = 'To',
    this.event_tags = '',
    this.from_age = '',
    this.to_age = '',
    this.comments = '',
    this.paid_event = false,
    this.male_price = '',
    this.female_price = '',
    this.created_date = '20',
    this.event_date = '',
    this.female_no = '20',
    this.male_no = '20',
    this.virtual_event = false,
    this.uid = "1",
    this.photo_url = '',
    this.total_ticket_volume = '',
    this.Request_Status = '',
    this.coShareList = const [],
    this.invitedFriends = const [],
    this.isCurrUserEvent = false,
    this.isCurrEvent = false,
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  EventState copyWith({
    String? img1,
    String? img2,
    String? img3,
    String? img4,
    String? title,
    String? food_bev,
    String? place,
    String? video_url,
    String? offering_option,
    List<String>? type,
    Map? event_map,
    String? from_time,
    String? to_time,
    String? event_tags,
    String? from_age,
    String? to_age,
    String? comments,
    bool? paid_event,
    String? male_price,
    String? female_price,
    String? created_date,
    String? event_date,
    String? female_no,
    String? male_no,
    bool? virtual_event,
    bool? is_user_event,
    bool? isCurrEvent,
    String? uid,
    String? photo_url,
    String? total_ticket_volume,
    String? Request_Status,
    List<String>? coShareList,
    List<String>? invitedFriends,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return EventState(
      img1: img1 ?? this.img1,
      isCurrEvent: isCurrEvent ?? this.isCurrEvent,
      img2: img2 ?? this.img2,
      img3: img3 ?? this.img3,
      img4: img4 ?? this.img4,
      title: title ?? this.title,
      food_bev: food_bev ?? this.food_bev,
      place: place ?? this.place,
      video_url: video_url ?? this.video_url,
      offering_option: offering_option ?? this.offering_option,
      type: type ?? this.type,
      event_map: event_map ?? this.event_map,
      from_time: from_time ?? this.from_time,
      to_time: to_time ?? this.to_time,
      event_tags: event_tags ?? this.event_tags,
      from_age: from_age ?? this.from_age,
      to_age: to_age ?? this.to_age,
      comments: comments ?? this.comments,
      paid_event: paid_event ?? this.paid_event,
      male_price: male_price ?? this.male_price,
      female_price: female_price ?? this.female_price,
      created_date: created_date ?? this.created_date,
      event_date: event_date ?? this.event_date,
      female_no: female_no ?? this.female_no,
      male_no: male_no ?? this.male_no,
      virtual_event: virtual_event ?? this.virtual_event,
      uid: uid ?? this.uid,
      photo_url: photo_url ?? this.photo_url,
      total_ticket_volume: total_ticket_volume ?? this.total_ticket_volume,
      Request_Status: Request_Status ?? this.Request_Status,
      coShareList: coShareList ?? this.coShareList,
      invitedFriends: invitedFriends ?? this.invitedFriends,
      isCurrUserEvent: isCurrUserEvent,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_main_pic': img1,
      'img2': img2,
      'img3': img3,
      'img4': img4,
      'event_name': title,
      'food_bev': food_bev,
      'event_address': place,
      'video_url': video_url,
      'offering_option': offering_option,
      'type': type,
      'event_map': event_map,
      'end_time': to_time,
      'start_time': from_time,

      'event_tags': event_tags,
      'age_from': from_age,
      'age_to': to_age,
      'Comments': comments,
      'paid_event': paid_event,
      'male_price': male_price,
      'female_price': female_price,
      'created_date': created_date,
      'event_date': event_date,
      'female_no': female_no,
      'male_no': male_no,
      'virtual_event': virtual_event,
      'event_id': uid,
      'photo_url': photo_url,
      'Request_Status': Request_Status,
      'total_ticket_volume': total_ticket_volume,
      'coShareList': coShareList,
      'invitedFriends': invitedFriends,
      'isCurrUserEvent': isCurrUserEvent,
      'isCurrEvent': isCurrEvent,
      // 'formSubmissionStatus': formSubmissionStatus.toMap(),
    };
  }

  factory EventState.fromMap(Map<String, dynamic> map) {
    // print('User Map');
    // print(List<Map>.from(map['created_by']));
    // print(map['created_by']);
    return EventState(
      img1: map['event_main_pic'].toString(),
      isCurrEvent: map['isCurrEvent'],
      img2: map['img2'].toString(),
      img3: map['img3'].toString(),
      img4: map['img4'].toString(),
      title: map['event_name'].toString(),
      food_bev: map['food_bev'].toString(),
      place: map['event_address'].toString(),
      video_url: map['video_url'].toString(),
      offering_option: map['offering_option'].toString(),
      type: map['type'] == Null ? List<String>.from(map['type']) : [],
      event_map: map == Null ? map : map,
      from_time: map['start_time'].toString(),
      to_time: map['end_time'].toString(),
      event_tags: map['event_tags'].toString(),
      from_age: map['age_from'].toString(),
      to_age: map['age_to'].toString(),
      comments: map['Comments'].toString(),
      paid_event: map['paid_event'] == 'NO' ? false : true,
      isCurrUserEvent: map['isCurrUserEvent'],
      male_price: map['male_price'].toString(),
      female_price: map['female_price'].toString(),
      created_date: map['created_date'].toString(),
      event_date: map['event_date'].toString(),
      female_no: map['female_count'].toString(),
      male_no: map['male_count'].toString(),
      virtual_event: map['private'] == 'NO' ? false : true,
      uid: map['event_id'].toString(),
      photo_url: map['photo_url'].toString(),
      total_ticket_volume: map['total_ticket_volume'].toString(),
      Request_Status: map['Request_Status'].toString(),
      coShareList: map['coShareList'] == Null
          ? List<String>.from(map['coShareList'])
          : [],
      invitedFriends: map['invitedFriends'] == Null
          ? List<String>.from(map['invitedFriends'])
          : [],

      // formSubmissionStatus: FormSubmissionStatus.fromMap(map['formSubmissionStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventState.fromJson(String source) =>
      EventState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventState(event_main_pic: $img1, Request_Status: $Request_Status, event_map: $event_map, img2: $img2, img3: $img3, event_date: $event_date, img4: $img4, event_name: $title, food_bev: $food_bev, event_address: $place, video_url: $video_url, offering_option: $offering_option, type: $type, event_date: $from_time, to_time: $to_time, event_tags: $event_tags, age_from: $from_age, age_to: $to_age, Comments: $comments, paid_event: $paid_event, male_price: $male_price, female_price: $female_price, created_date: $created_date, female_no: $female_no, virtual_event: $virtual_event, event_id: $uid, photo_url: $photo_url, total_ticket_volume: $total_ticket_volume, formSubmissionStatus: $formSubmissionStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventState &&
        other.img1 == img1 &&
        other.img2 == img2 &&
        other.img3 == img3 &&
        other.img4 == img4 &&
        other.isCurrEvent == isCurrEvent &&
        other.title == title &&
        other.food_bev == food_bev &&
        other.place == place &&
        other.video_url == video_url &&
        other.offering_option == offering_option &&
        listEquals(other.type, type) &&
        other.event_map == event_map &&
        other.from_time == from_time &&
        other.to_time == to_time &&
        other.event_tags == event_tags &&
        other.from_age == from_age &&
        other.to_age == to_age &&
        other.comments == comments &&
        other.paid_event == paid_event &&
        other.male_price == male_price &&
        other.female_price == female_price &&
        other.created_date == created_date &&
        other.event_date == event_date &&
        other.female_no == female_no &&
        other.male_no == male_no &&
        other.virtual_event == virtual_event &&
        other.uid == uid &&
        other.photo_url == photo_url &&
        other.total_ticket_volume == total_ticket_volume &&
        other.Request_Status == Request_Status &&
        listEquals(other.coShareList, coShareList) &&
        listEquals(other.invitedFriends, invitedFriends) &&
        other.isCurrUserEvent == isCurrUserEvent &&
        other.formSubmissionStatus == formSubmissionStatus;
  }

  @override
  int get hashCode {
    return img1.hashCode ^
        img2.hashCode ^
        img3.hashCode ^
        img4.hashCode ^
        isCurrEvent.hashCode ^
        title.hashCode ^
        food_bev.hashCode ^
        place.hashCode ^
        video_url.hashCode ^
        offering_option.hashCode ^
        type.hashCode ^
        event_map.hashCode ^
        from_time.hashCode ^
        to_time.hashCode ^
        event_tags.hashCode ^
        from_age.hashCode ^
        to_age.hashCode ^
        comments.hashCode ^
        paid_event.hashCode ^
        male_price.hashCode ^
        female_price.hashCode ^
        created_date.hashCode ^
        event_date.hashCode ^
        female_no.hashCode ^
        male_no.hashCode ^
        virtual_event.hashCode ^
        uid.hashCode ^
        photo_url.hashCode ^
        total_ticket_volume.hashCode ^
        isCurrUserEvent.hashCode ^
        formSubmissionStatus.hashCode;
  }
}
