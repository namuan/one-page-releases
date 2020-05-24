echo "###### OnePage Certificate ###############"

export CERTIFICATE_P12=Certificate.p12;
echo $OSX_CERTIFICATE_P12 | base64 --decode > $CERTIFICATE_P12;

export KEYCHAIN=build.keychain;
security create-keychain -p $OSX_CERTIFICATE_P12_PWD $KEYCHAIN;
security default-keychain -s $KEYCHAIN;
security unlock-keychain -p $OSX_CERTIFICATE_P12_PWD $KEYCHAIN;

security import $CERTIFICATE_P12 -k $KEYCHAIN -P $OSX_CERTIFICATE_P12_PWD -T /usr/bin/codesign;
security set-key-partition-list -S apple-tool:,apple: -s -k $OSX_CERTIFICATE_P12_PWD $KEYCHAIN

echo "###### OnePage Code Signing ###############"

ID="Developer ID Application: Nauman Leghari (Z8242PZ338)"

for filename in $(find dist/OnePage.app -name "*.dylib"); do
	echo "Signing $filename"
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(find dist/OnePage.app -name "*.so"); do
    echo "Signing $filename"
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(find dist/OnePage.app/Contents/MacOS -name "Qt*"); do
    echo "Signing $filename"
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

for filename in $(ls dist/OnePage.app/Contents/MacOS/PyQt5/Qt/translations/*); do
    echo "Signing $filename"
    codesign -v -f -i "dev.deskriders.onepage" -s "$ID" $filename
done

codesign -v -f -s "$ID" /Users/nmn/workspace/one-page/dist/OnePage.app/Contents/MacOS/base_library.zip

codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/python
codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app/Contents/MacOS/app
codesign -v -f --entitlements entitlements.plist -s "$ID" dist/OnePage.app

# Add verification
# spctl --raw -vvv --assess --type exec dist/OnePage.app

# remove certs
rm -fr *.p12
