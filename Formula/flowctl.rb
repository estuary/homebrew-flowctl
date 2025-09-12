class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.21.tar.gz"
  sha256 "69f9c2f9277c86f76aa2a560dccd2032f4ab5f87bab34b813157998a1dac747f"
  license "Business Source License 1.1"
  version "0.5.21"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.21/flowctl-multiarch-macos"
      sha256 "f718a5e5c3f38214a193deca19f186e9190c809c9f6e407430f78264fc5e4c50"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.21/flowctl-x86_64-linux"
      sha256 "891d4871a24fcec00a3f1922903be8e0b556cc7cebf860831e12d3430203d79e"
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
