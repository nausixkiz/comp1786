class EventModel {
  String activityName;
  String? location;
  String dateHeld;
  String? timeOfAttending;
  String nameOfReporter;

  EventModel({
    required this.activityName,
    this.location,
    required this.dateHeld,
    required this.timeOfAttending,
    required this.nameOfReporter,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'location': location,
      'dateHeld': dateHeld,
      'timeOfAttending': timeOfAttending,
      'nameOfReporter': nameOfReporter,
    };
  }

  @override
  String toString() {
    return 'Event{activity name: $activityName, location: $location, date: $dateHeld, timeOfAttending: $timeOfAttending, nameOfReporter: $nameOfReporter}';
  }

}