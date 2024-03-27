extension StringExt on String? {
  bool get emailValid =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this ?? '');
  bool get upperCaseLetterValid => RegExp(r'[A-Z]').hasMatch(this ?? '');
  bool get lowerCaseLetterValid => RegExp(r'[a-z]').hasMatch(this ?? '');
  bool get numberValid => RegExp(r'[0-9]').hasMatch(this ?? '');
  bool minCharacters(int count) => (this?.length ?? 0) >= count;
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}
