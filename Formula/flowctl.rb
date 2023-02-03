class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  url "https://github.com/estuary/flow/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "559ed0e74e53e4776781355aa7fadefb97f63ebae4ed1f2924764591f2fcccb8"
  license "Business Source License 1.1"
  version "0.1.8"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "29aee07bed626964b585c18323a5d5170cd94d183ced7658cdde03e72cddbe05"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "4d6305c700db7c92f22a55c54714159aff7f04fc7a1be164b77ee9f443d82f7a"
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
