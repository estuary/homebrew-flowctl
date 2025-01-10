class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.9.tar.gz"
  sha256 "62a0eb3a8507c5186609ffb509fd0bbec0235cbda02696decc25c2457f7e9891"
  license "Business Source License 1.1"
  version "0.5.9"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.9/flowctl-multiarch-macos"
      sha256 "b422e888dfe7b3158fb13a33624dc55c24e707fcf611112e3d1f3ecf915ba077"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.9/flowctl-x86_64-linux"
      sha256 "105ddbbd751bf6c9e1f10bed3753283cefdfcc459a0c9d319c6158ebe05ebcb7"
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
