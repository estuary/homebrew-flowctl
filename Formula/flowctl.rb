class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "686f35055b92b6221b4d7a0f009e45ea4e2d3419bff38afd029375273e8abed2"
  license "Business Source License 1.1"
  version "0.4.0"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.4.0/flowctl-multiarch-macos"
      sha256 "ab1b9dd19e9ae53d2618b27c3e28c826be2040ff6469a602c30af585aa479780"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.4.0/flowctl-x86_64-linux"
      sha256 "c330b2492f4068ee35054fe043da2fe22c75600a93dfe53fec50daf9bca4ae13"
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
