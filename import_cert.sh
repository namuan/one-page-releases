export CERTIFICATE_P12=Certificate.p12;
echo $OSX_CERTIFICATE_P12 | base64 --decode > $CERTIFICATE_P12;
export KEYCHAIN=build.keychain;
security create-keychain -p $OSX_CERTIFICATE_P12_PWD $KEYCHAIN;
security default-keychain -s $KEYCHAIN;
security unlock-keychain -p $OSX_CERTIFICATE_P12_PWD $KEYCHAIN;
security import $CERTIFICATE_P12 -k $KEYCHAIN -P $OSX_CERTIFICATE_P12_PWD -T /usr/bin/codesign;
security set-key-partition-list -S apple-tool:,apple: -s -k travis $KEYCHAIN

./mac-codesign.sh

# remove certs
rm -fr *.p12