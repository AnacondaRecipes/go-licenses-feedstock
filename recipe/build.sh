#!/bin/bash

if [[ "${target_platform}" == "win-64" ]]; then
  go build -v -o $PREFIX/bin/go-licenses.exe
else
  go build -v -o $PREFIX/bin/go-licenses
fi

go-licenses save . --save_path=./license-files

# TODO: remove if not actually needed, see #6
# rm -r ./license-files/github.com/google/licenseclassifier/licenses

# Make GOPATH directories writeable so conda-build can clean everything up.
find "$( go env GOPATH )" -type d -exec chmod +w {} \;
