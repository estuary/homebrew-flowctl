class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.10.tar.gz"
  sha256 "0f9f9e89b8f7d8c7f3986e2c450f76a91788562f399d2ba296d829bb5d6bd05f"
  license "Business Source License 1.1"
  version "0.6.10"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.10/flowctl-multiarch-macos"
      sha256 "62c35a75f1e78fb1d31a9cc412570451188799c2967cb3dd2f7c90e2bc22cb75"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.10/flowctl-x86_64-linux"
      sha256 "26b80ac6b86e59fde38db5d9b009a60c0e142a54884851eb46bd84d0625b445a"
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
