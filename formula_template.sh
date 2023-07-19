#!/bin/bash

# e.g 0.1.3
ARCHIVE_URL="https://github.com/estuary/flow/archive/refs/tags/v{$FLOW_RELEASE_NAME}.tar.gz"

DOWNLOADS_BASE="https://github.com/estuary/flow/releases/download"
MACOS_BINARY="$DOWNLOADS_BASE/v$FLOW_RELEASE_NAME/flowctl-multiarch-macos"
LINUX_X86_BINARY="$DOWNLOADS_BASE/v$FLOW_RELEASE_NAME/flowctl-x86_64-linux"

ARCHIVE_SHA=$(curl -sL "$ARCHIVE_URL" | shasum -a 256 | cut -f 1 -d " ")
MACOS_SHA=$(curl -sL "$MACOS_BINARY" | shasum -a 256 | cut -f 1 -d " ")
LINUX_X86_SHA=$(curl -sL "$LINUX_X86_BINARY" | shasum -a 256 | cut -f 1 -d " ")

cat << EOF
class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v$FLOW_RELEASE_NAME.tar.gz"
  sha256 "$ARCHIVE_SHA"
  license "Business Source License 1.1"
  version "$FLOW_RELEASE_NAME"

  on_macos do
    resource "flowctl-binary" do
      url "$MACOS_BINARY"
      sha256 "$MACOS_SHA"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "$LINUX_X86_BINARY"
      sha256 "$LINUX_X86_SHA"
    end
  end

  def install
    binary_name = "flowctl-multiarch-macos"
    if OS.linux?
      binary_name = "flowctl-x86_64-linux"
    end

    resource("flowctl-binary").stage do
      bin.install binary_name => "flowctl"
    end

  end

  test do
    system "flowctl", "--version"
  end
end
EOF