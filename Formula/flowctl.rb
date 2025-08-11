class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.20.tar.gz"
  sha256 "dbf99f108a124d41643ba7f8cf17d3f78837e583af03155b3b22d5d79b783b94"
  license "Business Source License 1.1"
  version "0.5.20"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.20/flowctl-multiarch-macos"
      sha256 "b301e6962a0b8dd21a58ac74436fd725ecc53614bea3ff02161d8b864b008391"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.20/flowctl-x86_64-linux"
      sha256 "d60322c7e26fbee3a389313bc7a3ed91a0aac40a84c49d53d7bdce9dc0bb5bb8"
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
