enum DificultyLevel { empty, beginner, middle, professional }

extension DificultyLevelExt on DificultyLevel {
  String? toJson() {
    switch (this) {
      case DificultyLevel.empty:
        return 'empty';
      case DificultyLevel.beginner:
        return 'beginner';
      case DificultyLevel.middle:
        return 'middle';
      case DificultyLevel.professional:
        return 'professional';
      default:
        return null;
    }
  }

  String? toDisplay() {
    switch (this) {
      case DificultyLevel.empty:
        return 'Уровень не указан';
      case DificultyLevel.beginner:
        return 'Начинающий уровень';
      case DificultyLevel.middle:
        return 'Средний уровень';
      case DificultyLevel.professional:
        return 'Продвинутый уровень';
      default:
        return null;
    }
  }

  static DificultyLevel? fromJson(String jsonValue) {
    switch (jsonValue) {
      case 'empty':
        return DificultyLevel.empty;
      case 'beginner':
        return DificultyLevel.beginner;
      case 'middle':
        return DificultyLevel.middle;
      case 'professional':
        return DificultyLevel.professional;
      default:
        return null;
    }
  }
}