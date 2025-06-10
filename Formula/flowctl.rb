class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.15.tar.gz"
  sha256 "53083973536083343fe95a96a0e8107b0c7c32b43d0c20e720211fb8fd6ad73d"
  license "Business Source License 1.1"
  version "0.5.15"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.15/flowctl-multiarch-macos"
      sha256 "c1f16a0081ee7e84d7e13ab72011f134c821b8a4708a3c3ff751db0c8e14b69b"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.15/flowctl-x86_64-linux"
      sha256 "a45c148cc1c270b55f253b28df1db35755246239f0858a44637f2c1cea23eb52"
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
