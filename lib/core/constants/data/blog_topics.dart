enum BlogTopics {
  technology(value: 'Technology'),
  business(value: 'Business'),
  programming(value: 'Programming'),
  entertainment(value: 'Entertainment');

  const BlogTopics({required this.value});

  final String value;
}
