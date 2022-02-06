# fvm
if ! type "fvm" > /dev/null; then
    dart pub global activate fvm
fi

if ! type "flutter" > /dev/null; then
    fvm install 2.8.1
    fvm global 2.8.1
fi
