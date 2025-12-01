#!/usr/bin/env bash

set -eux -o pipefail

# Let Go use the appropriate toolchain for go.mod (e.g., 1.23).
# Do NOT set GOTOOLCHAIN=local here, or Go 1.21.5 will refuse to build.
export GOTOOLCHAIN=auto

# Use the no-CGO toolchain where applicable.
export CGO_ENABLED=0

# Build the main go-licenses binary into PREFIX/bin.
go build -v -o "${PREFIX}/bin/go-licenses"

# Removed because running `go-licenses save .` forces the tool to analyze all
# direct and transitive dependencies of the project, including the Go standard
# library. With modern Go versions (1.22+), the standard library is provided
# through the `golang.org/toolchain` module, which does not expose module
# metadata. As a result, `go-licenses` fails with "Non go modules projects are
# no longer supported" errors. This breaks the build, so the command is omitted.
# go-licenses save . --save_path=./license-files

# Make GOPATH directories writable so conda-build can clean everything up.
CLEAN_GO_PATH="$(go env GOPATH)"
export CLEAN_GO_PATH
find "${CLEAN_GO_PATH}" -type d -exec chmod +w {} \;
