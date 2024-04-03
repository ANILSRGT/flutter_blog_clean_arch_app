enum ErrorContentTypes {
  auth(codeCharacter: 'AU'),
  blog(codeCharacter: 'BL'),
  utils(codeCharacter: 'UT');

  const ErrorContentTypes({
    required this.codeCharacter,
  });

  final String codeCharacter;
}
