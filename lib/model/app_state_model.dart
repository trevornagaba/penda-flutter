import 'package:flutter/foundation.dart' as foundation;

import 'event.dart';
import 'event_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  // All events
  List<Event> _events;

  List<Event> getEvents() {
    if (_events == null) {
      return [];
    } else {
      return List.from(_events);
    }
  }

  // Loads the list of available products from the repo.
  void loadEvents() {
    _events = EventRepository.loadEvents();
    notifyListeners();
  }

  void contributeToEvent(int eventId) {
    // TODO: Add flutterwave payments logic
  }
}
