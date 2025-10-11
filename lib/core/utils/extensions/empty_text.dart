extension EmptyText on String? {
  String defaultEmptyText({String? content}) {
    if (this == null) return content ?? '-';
    if (this!.isEmpty) return content ?? '-';
    return this!;
  }
}
