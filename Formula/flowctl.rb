class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.24.tar.gz"
  sha256 "ff5cfa71b1a52d04511ff507676e924c56d56ca46effd6dec25e4146245b3b49"
  license "Business Source License 1.1"
  version "0.5.24"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.24/flowctl-multiarch-macos"
      sha256 "dce70e2036e09bbf4486c8153fd9a3d692a2df4710fb79eb76115f9f21c97a45"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.24/flowctl-x86_64-linux"
      sha256 "218cd3feeecdad8182e2d5b281abea1d74f605342feff48bcf557d4250d45083"
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
