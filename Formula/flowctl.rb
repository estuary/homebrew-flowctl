class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.13.tar.gz"
  sha256 "0ae115e641ac59767c072b63343e38355c64311fdce7b3514debbfbe90f80605"
  license "Business Source License 1.1"
  version "0.6.13"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.13/flowctl-multiarch-macos"
      sha256 "3238b5c8b677dd8dd12201b4d5ef97f844c74b0f6cd199b52a482aaa525a6576"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.13/flowctl-x86_64-linux"
      sha256 "edf66d27761e5688a05200f2935cb86f816b7e52582eaffd1f5aef2f002d27d2"
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
