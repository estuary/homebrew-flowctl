class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.11.tar.gz"
  sha256 "1a118a68643621b0b6ee6db01f1911f0656420a970829d781a5ed9cf84a1418c"
  license "Business Source License 1.1"
  version "0.6.11"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.11/flowctl-multiarch-macos"
      sha256 "c50676160f24108053105167c6efd83c00b75dd25d770b17144551d7cc2914d3"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.11/flowctl-x86_64-linux"
      sha256 "68f81d827e9318580a219c3babb6b1ab970dbb6a3758b746e448f6bfda498166"
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
