flutter clean
rm -Rf Pods
rm -Rf .symlinks 
rm -Rf Podfile 
flutter pub get
pod cache clean --all
pod install
flutter build ios
