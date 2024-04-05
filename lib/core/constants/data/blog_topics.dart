enum BlogTopics {
  technology(value: 'Technology'),
  business(value: 'Business'),
  programming(value: 'Programming'),
  entertainment(value: 'Entertainment');

  const BlogTopics({required this.value});

  final String value;

  static BlogTopics fromString(String value) {
    return BlogTopics.values.firstWhere((element) => element.value == value);
  }
}
