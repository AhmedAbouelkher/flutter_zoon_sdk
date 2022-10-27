localization_watch:
	reflex -s -r '\.json$$' make localization

localization_watch_fvm:
	reflex -s -r '\.json$$' make localization_fvm

get:
	flutter pub get

clean:
	flutter clean 
	make get

build_android_apk:
	clear
	make clean 
	flutter build apk --target-platform android-arm64 --split-per-abi
	open build/app/outputs/flutter-apk

build_ios:
	clear 
	make clean 
	make build 
	flutter build ipa  
	open ./build/ios/archive/Runner.xcarchive 