enum ErrorTypes {
  server(
    codeCharacter: 'S',
  );

  const ErrorTypes({
    required this.codeCharacter,
  });

  final String codeCharacter;
}
