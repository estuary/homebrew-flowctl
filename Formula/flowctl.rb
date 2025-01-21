class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.10.tar.gz"
  sha256 "cea36f612583e21ad4ac883d815a6940ec8eb0a2734bc904085444755efd5e9a"
  license "Business Source License 1.1"
  version "0.5.10"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.10/flowctl-multiarch-macos"
      sha256 "bf91427e57ea311a9b889a40501451193123551002708e346e89529bc974c597"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.10/flowctl-x86_64-linux"
      sha256 "6944149d9987708e5c3c9eb0bc36cd2df2a4b4ce433b0ca54eecc39e63cf20aa"
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
