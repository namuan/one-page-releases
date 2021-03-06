## OnePage Releases

### Windows

Commit Version updates first so that Windows CI build can create a new Github Release version

### MacOS

**Step 1: "Make Application Bundle"**

```
$ cd workspace/one-page
$ python --version
$ make reset
$ make package
```

**Step 2: "Submit to Apple"**

```
$ cd ../one-page-releases
$ USER="" KEYCHAIN="" APP_NAME="" IDENTITY="" CERT_ID="" ./macos-release.sh
```

**Step 3: "Check Notarization Status"**

Run the output command from the previous step

**Step 4: "Upload to Github"**

Depends on `$ npm install -g github-release-cli`

```
$ cat .travis.yml | grep BUILD_VERSION=
$ OWNER="github-repo-owner" ./upload-github-release.sh VERSION
```

