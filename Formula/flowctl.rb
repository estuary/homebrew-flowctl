class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.13.tar.gz"
  sha256 "e77a36e0b8ef9fdc15d88e413e9a424a59ce463d6cbeb015aa7e164907f07d44"
  license "Business Source License 1.1"
  version "0.3.13"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.13/flowctl-multiarch-macos"
      sha256 "8a3ab7907ba4d7b171eb96f7d5bc271fc2db41fcb4cdb459c58046a63ac08182"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.13/flowctl-x86_64-linux"
      sha256 "7b5a5e0082fc6a4cb5fc028944ced90749d8ef8f7ab403b43cdb5b8d02295f53"
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
