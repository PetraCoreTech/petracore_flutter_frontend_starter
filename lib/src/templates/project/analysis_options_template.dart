String analysisOptionsTemplate() => '''
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    avoid_print: false
    prefer_single_quotes: true
    always_declare_return_types: true
    always_put_required_named_parameters_first: true
    always_use_package_imports: true
    annotate_overrides: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    require_trailing_commas: true
    sort_child_properties_last: true
    sort_constructors_first: true
    lines_longer_than_80_chars: false
''';
