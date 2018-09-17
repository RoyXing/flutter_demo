import 'package:event_bus/event_bus.dart';

class Constants {

  static final String END_LINE_TAG = 'COMPLETE';
  static final String EMPTY_VIEW_TAG = 'EMPTY';

  static EventBus eventBus = new EventBus();
}
