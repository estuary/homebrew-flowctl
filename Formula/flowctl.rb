class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.6.tar.gz"
  sha256 "f389c6a8c1b233176740f5ddfb87fe684e8465276a5f2cd175ea383bb0d18f35"
  license "Business Source License 1.1"
  version "0.6.6"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.6/flowctl-multiarch-macos"
      sha256 "d4940680a8399d186fd1c19182f9252b4418a02ad92b7f2597aa17a1ede5b2a2"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.6/flowctl-x86_64-linux"
      sha256 "96c81270ae905b24d3afcc32e64e85f2f1158916427bb8ee77c994fbb1022b8f"
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
