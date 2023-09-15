class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "e1b7cae74cdbe8e0dba9c03d12900362c6a0e6d56b721eada01af9e01a94d5a1"
  license "Business Source License 1.1"
  version "0.3.6"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.6/flowctl-multiarch-macos"
      sha256 "7d0b8afa360abba5c376afad8cc5f96b995669ddc028fe214512de4f92dd1592"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.6/flowctl-x86_64-linux"
      sha256 "649be06d9a9158ef692a34342b45109cc92c05ce0d2836df0d8abf7e1e5b09c5"
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
