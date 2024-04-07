enum ErrorContentTypes {
  auth(codeCharacter: 'AU'),
  blog(codeCharacter: 'BL'),
  utils(codeCharacter: 'UT'),
  network(codeCharacter: 'NE');

  const ErrorContentTypes({
    required this.codeCharacter,
  });

  final String codeCharacter;
}
