class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.13.tar.gz"
  sha256 "c7a7d450a1375b0c2a9a369c1c4581711e6cab96362996df46ffbad228de6bdb"
  license "Business Source License 1.1"
  version "0.5.13"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.13/flowctl-multiarch-macos"
      sha256 "990e5133469a6bba9cb6b7dabbdb47d6249cca6d9b9ce71a95af1a983bf11aea"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.13/flowctl-x86_64-linux"
      sha256 "e1a70d9f6ddf022b2a9c44682e1d88ff4397357473ec5c44d179dd409735d055"
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
