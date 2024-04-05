enum SportExersizeType { empty, cardio, strength, stretch }

extension SportExersizeTypeExt on SportExersizeType {
  String toJson() {
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
        throw Exception('Неизвестное значение перечисления: $this');
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