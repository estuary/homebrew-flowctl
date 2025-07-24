class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.18.tar.gz"
  sha256 "d989691e610ff65b951075d6e2f3c7367f3107fc1bc680df86e4212dce3478df"
  license "Business Source License 1.1"
  version "0.5.18"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.18/flowctl-multiarch-macos"
      sha256 "5c2adfea17c4616f5dbe78dfc71112d4895851231e3b3b99afda8a313fdc9029"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.18/flowctl-x86_64-linux"
      sha256 "aab9181f4c93a0655a2edae404dc6d93cdb1b58d5baa3034312358a3fe09ab1c"
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
