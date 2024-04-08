enum SportExersizeType { cardio, strength, stretch, empty }

extension SportExersizeTypeExt on SportExersizeType {
  String? toJson() {
    switch (this) {
      case SportExersizeType.empty:
        return 'empty';
      case SportExersizeType.cardio:
        return 'cardio';
      case SportExersizeType.strength:
        return 'strength';
      case SportExersizeType.stretch:
        return 'stretch';
      default:
        return null;
    }
  }

  String? toDisplay() {
    switch (this) {
      case SportExersizeType.empty:
        return 'Тип не указан';
      case SportExersizeType.cardio:
        return 'Кардио';
      case SportExersizeType.strength:
        return 'Силовые';
      case SportExersizeType.stretch:
        return 'Растяжка';
      default:
        return null;
    }
  }
static SportExersizeType? fromJson(String jsonValue) {
  switch (jsonValue) {
    case 'empty':
      return SportExersizeType.empty;
    case 'cardio':
      return SportExersizeType.cardio;
    case 'strength':
      return SportExersizeType.strength;
    case 'stretch':
      return SportExersizeType.stretch;
    default:
      return null;
  }
}
}