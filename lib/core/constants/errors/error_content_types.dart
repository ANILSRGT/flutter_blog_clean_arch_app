enum ErrorContentTypes {
  auth(
    codeCharacter: 'AU',
  );

  const ErrorContentTypes({
    required this.codeCharacter,
  });

  final String codeCharacter;
}
