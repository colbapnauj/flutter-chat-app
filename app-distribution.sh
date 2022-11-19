#!/bin/sh

firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --app 1:57106052935:android:62aa6b4c711fab8aef7e62 --release-notes "Bug fixes and improvements" --testers-file ~/documents/testers.txt