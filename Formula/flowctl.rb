class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.16.tar.gz"
  sha256 "a2da30f472eccb0b3dda5ec15bcf044dbfac2885ade188aef7b10d0b10c4e587"
  license "Business Source License 1.1"
  version "0.5.16"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.16/flowctl-multiarch-macos"
      sha256 "6b4f2a32cade35bb64468c9bdf3082836da46792aa8a343c76f04d837cd3299b"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.16/flowctl-x86_64-linux"
      sha256 "c30fe938f70786388630d0032c1b6f2a0a18a04bf1ab6c6b186688a7f914b088"
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
