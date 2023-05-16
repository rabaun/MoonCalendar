enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

MoonPhase getMoonPhase(DateTime date) {
  final lunarCycle = 29.5305882; // days
  final baseDate = DateTime.utc(2000, 1, 6, 18, 14, 0);
  final diff = date.difference(baseDate).inSeconds;
  final phase = (diff / (lunarCycle * 86400) + 0.5) % 1;

  if (phase <= 0.02 || phase >= 0.98) {
    return MoonPhase.newMoon;
  } else if (phase <= 0.24) {
    return MoonPhase.waxingCrescent;
  } else if (phase <= 0.26) {
    return MoonPhase.firstQuarter;
  } else if (phase <= 0.49) {
    return MoonPhase.waxingGibbous;
  } else if (phase <= 0.51) {
    return MoonPhase.fullMoon;
  } else if (phase <= 0.74) {
    return MoonPhase.waningGibbous;
  } else if (phase <= 0.76) {
    return MoonPhase.lastQuarter;
  } else {
    return MoonPhase.waningCrescent;
  }
}

bool isFullMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.fullMoon;
}

bool isWaningMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.waningCrescent || phase == MoonPhase.lastQuarter || phase == MoonPhase.waningGibbous;
}

bool isWaxingMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.newMoon || phase == MoonPhase.waxingCrescent || phase == MoonPhase.firstQuarter || phase == MoonPhase.waxingGibbous;
}

bool isNewMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.newMoon;
}

bool isFirstQuarterMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.firstQuarter;
}

bool isLastQuarterMoon(DateTime date) {
  final phase = getMoonPhase(date);
  return phase == MoonPhase.lastQuarter;
}
