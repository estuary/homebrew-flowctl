class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "9217797dd8e48eb9b82498a4846418342367a367412b99e43276233a18821f1e"
  license "Business Source License 1.1"
  version "0.3.3"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.3/flowctl-multiarch-macos"
      sha256 "424b5d8c21fdacbdcca70758f37ccc84b33e6c5ce4b6cbffcaf375d30872f1d3"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.3/flowctl-x86_64-linux"
      sha256 "e925565a4c883b8982a3457329939d335051c313ed5001db025cdaefb48c04f6"
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
