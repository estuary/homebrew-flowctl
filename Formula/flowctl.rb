class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "5b4c0c74dd5a59a7ef129244871d327d5dc2e6034fd6770852bb0eb2e87eb7c4"
  license "Business Source License 1.1"
  version "0.5.7"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.7/flowctl-multiarch-macos"
      sha256 "0b3dfd76012a6068cb30768d93a3e792664187df420bffd1c02e9b92859fec6d"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.7/flowctl-x86_64-linux"
      sha256 "ce266402fd53fc8f3edb91b66187af0dd441da0d33972b9bd4f52d4f1d381575"
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
