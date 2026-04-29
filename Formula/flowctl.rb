class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.7.tar.gz"
  sha256 "8cb20e84110a320eb3dc239298dcbcfbf66cc620cc180a5641ea5a4abe0d6956"
  license "Business Source License 1.1"
  version "0.6.7"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.7/flowctl-multiarch-macos"
      sha256 "24062dcfa0c0c8204ca5805b117e2a545c5e4723abfebd14abaf3c6c1c5c51bf"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.7/flowctl-x86_64-linux"
      sha256 "7cf1ac11c548bd4c9e2cffeac872b108b407bb40f6bc3e66d3f1888e068b5a76"
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
