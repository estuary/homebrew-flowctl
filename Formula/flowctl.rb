class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  url "https://github.com/estuary/flow/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "8dcc4410c4fd56ef2902ac7b6ae675834091205e7457a0bed93946c5f02b5ab6"
  license "Business Source License 1.1"
  version "0.1.6"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "c760f7c9f3f684f9769e13c22133334d8fdf5a65669b6289e0634197f192874e"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "17ef11b18cff83c8e0d7ad180e8b798b9089817b80b2a91fce14dc1f0aa70ea8"
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
