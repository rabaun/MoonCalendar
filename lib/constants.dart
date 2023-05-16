import 'package:intl/intl.dart';

enum PageState {
  error,
  success,
  info,
  isEmpty,
  hasData,
  load,
}

enum DirectionType {
  incoming('Входящий'),
  outgoing('Исходящий'),
  missed("Пропущенный");

  const DirectionType(this.value);

  final String value;
}

enum EkadashiType {
  isFullMoon('полнолуние'),
  isWaxingMoon('Растущая'),
  isWaningMoon("Убывающая"),
  isEkadashi("Экадаши");

  const EkadashiType(this.value);

  final String value;
}

String getDirectionType(String? value) {
  DirectionType directionType = DirectionType.incoming;
  switch (value) {
    case "in":
      directionType = DirectionType.incoming;
      break;
    case "out":
      directionType = DirectionType.outgoing;
      break;
    case "missed":
      directionType = DirectionType.missed;
      break;
  }
  return directionType.value;
}

String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";

final RegExp emailRegex = RegExp(pattern);

RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

DateFormat inputDateFormat = DateFormat('dd-MM-yyyy hh:mm:ss a');

List<String> monthList = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];
