enum ErrorTypes {
  server(codeCharacter: 'S'),
  unknown(codeCharacter: 'U');

  const ErrorTypes({
    required this.codeCharacter,
  });

  final String codeCharacter;
}
