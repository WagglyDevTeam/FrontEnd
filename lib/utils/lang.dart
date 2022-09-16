class Lang {
  change(en) {
    if (en != null) {
      switch (en) {
        case 'art':
          return '예술계열';
        case 'nature_science':
          return '자연계열';
        case 'engineering_science':
          return '공학계열';
        case 'social':
          return '인문계열';
        default:
          '없음';
      }
    } else {
      return '없음';
    }
  }
}
