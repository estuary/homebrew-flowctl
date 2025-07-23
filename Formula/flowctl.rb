class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.17.tar.gz"
  sha256 "c23c922233fe82fd910a35d1765300148f8cdca0583b72d311f2444c17a48a35"
  license "Business Source License 1.1"
  version "0.5.17"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.17/flowctl-multiarch-macos"
      sha256 "558238fc726e18d2ec057b27f8706003e7e1fabbde5ba8b3b331e6e06f61e12e"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.17/flowctl-x86_64-linux"
      sha256 "31ac995fee904fa06037aa96cba83a8ef982d73062d264fed35f88cac159874e"
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
