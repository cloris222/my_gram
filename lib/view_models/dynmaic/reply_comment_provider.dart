import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/http/data/post_comment_data.dart';

final replyCommentProvider = StateProvider.autoDispose<PostCommentData?>((ref) {
  return null;
});
