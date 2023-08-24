class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  # For example: `shasum -a 256 v0.3.2.tar.gz`
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "265f45b9a3dff21b2d76eb431cafa0b1e80485ee9f0316a6d96391ffca7f688b"
  license "Business Source License 1.1"
  version "0.3.5"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "4a9bfafb587c5093fc4b55862c3b02d127ddb737c3b4a91d929155c916892a80"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "74e75942965fb5af36f07c221162ef15b6b9233eb847e4fd1926b6b6e7f26216"
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
