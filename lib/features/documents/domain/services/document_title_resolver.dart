import 'package:injectable/injectable.dart';

@lazySingleton
class DocumentTitleResolver {
  const DocumentTitleResolver();

  String resolve(String title, Set<String> existingTitles) {
    if (!existingTitles.contains(title)) {
      return title;
    }

    var suffix = 2;
    while (existingTitles.contains('$title $suffix')) {
      suffix++;
    }
    return '$title $suffix';
  }
}
