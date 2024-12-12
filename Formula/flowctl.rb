class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.8.tar.gz"
  sha256 "6c31f4e1e1dc121310f189b3a1902cddf9d14c4bb583ae8d88b0d6132500f236"
  license "Business Source License 1.1"
  version "0.5.8"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.8/flowctl-multiarch-macos"
      sha256 "2f4a5d606934109e372fbf1e483613ca4b12561f296c3a531548b4b667063486"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.8/flowctl-x86_64-linux"
      sha256 "ade25ca1186824170e96f647b74d49d7dacacc603a54a50f1ad9e7c3dceca8d1"
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
