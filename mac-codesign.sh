echo "###### OnePage Code Signing ###############"

ID="Developer ID Application: Nauman Leghari (Z8242PZ338)"

for filename in $(find dist/OnePage.app -name "*.dylib"); do
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(find dist/OnePage.app -name "*.so"); do
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(find dist/OnePage.app/Contents/MacOS -name "Qt*"); do
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(ls dist/OnePage.app/Contents/MacOS/PyQt5/Qt/translations/*); do
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

codesign -v -f -s "$ID" dist/OnePage.app/Contents/MacOS/base_library.zip

echo "Signing python"
codesign -v -f -o runtime --timestamp --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/python
echo "Signing app"
codesign -v -f -o runtime --timestamp --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/app
echo "Signing OnePage.app"
codesign -v -f -o runtime --timestamp --entitlements entitlements.plist -s "$ID" dist/OnePage.app

# Add verification
#spctl --raw -vvv --assess --type exec dist/OnePage.app

# remove certs
rm -fr *.p12