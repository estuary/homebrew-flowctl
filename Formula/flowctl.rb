class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.16.tar.gz"
  sha256 "81a3e39f20864d7d0c2bbca5b3b3220914ffc971bfc377f208de0705ca4fd347"
  license "Business Source License 1.1"
  version "0.6.16"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.16/flowctl-multiarch-macos"
      sha256 "584e27ccdd9ee5b8a14149eeb7e44742649a1900e2415427114e5fb737a1513c"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.16/flowctl-x86_64-linux"
      sha256 "a9be844e3903f3e5350c7fbf2ab03bf35fb7b984d54d83ba41bb83f799be791a"
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
