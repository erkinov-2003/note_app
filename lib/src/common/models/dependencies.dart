import 'package:flutter/cupertino.dart';

import '../initialize/inherited_dependencies.dart';

abstract interface class Dependencies {
  static Dependencies of(BuildContext context) => InheritedDependencies.of(context);
}

final class MutableDependencies implements Dependencies {
  Dependencies freeze() => const ImmutableDependencies();
}

final class ImmutableDependencies implements Dependencies {
  const ImmutableDependencies();
}
