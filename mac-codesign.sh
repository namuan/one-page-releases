echo "###### OnePage Code Signing ###############"

ID="Developer ID Application: Nauman Leghari (Z8242PZ338)"

for filename in $(find dist/OnePage.app/ -name "*.dylib"); do
	echo "Signing $filename"
    /usr/bin/codesign -v -f -s "$ID" $filename
done

for filename in $(find dist/OnePage.app/ -name "*.so"); do
    echo "Signing $filename"
    /usr/bin/codesign -v -f -s "$ID" $filename
done

for filename in $(find dist/OnePage.app/Contents/MacOS -name "Qt*"); do
    echo "Signing $filename"
    /usr/bin/codesign -v -f -s "$ID" $filename
done

for filename in $(ls dist/OnePage.app/Contents/MacOS/PyQt5/Qt/translations/*); do
    echo "Signing $filename"
    /usr/bin/codesign -v -f -s "$ID" $filename
done

/usr/bin/codesign -v -f -s "$ID" /Users/nmn/workspace/one-page/dist/OnePage.app/Contents/MacOS/base_library.zip

/usr/bin/codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/python
/usr/bin/codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/app
/usr/bin/codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app

# Add verification
# spctl --raw -vvv --assess --type exec dist/OnePage.app