class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "8dadd09ed4712cd70e8480fb375fb87cd80c7a159903af1d53cc2e51064fd6dc"
  license "Business Source License 1.1"
  version "0.5.0"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.0/flowctl-multiarch-macos"
      sha256 "677d7a1fc5f23888e60ba6c74f531fb9b9102c125650f3f992cf9a6a728159ba"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.0/flowctl-x86_64-linux"
      sha256 "d21dbdb71331b6163be2051af9bdfac139680d2a5c1b246f6e36d15e87dd87e8"
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
