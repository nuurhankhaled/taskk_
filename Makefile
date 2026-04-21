.PHONY: build-runner
build-runner:
	dart run build_runner build --delete-conflicting-outputs

.PHONY: gen-l10n
gen-l10n:
	flutter pub run easy_localiz=-tion:generate -S assets/l10n -f keys -O lib/generated/translations -o locale_keys.g.dart

.PHONY: analyze
analyze:
	flutter analyze

.PHONY: dart-fix
dart-fix:
	dart fix --apply
