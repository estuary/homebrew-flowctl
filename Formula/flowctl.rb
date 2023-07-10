class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  # For example: `shasum -a 256 v0.3.1.tar.gz`
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "aa4ccc32b8a014a77462c607fe7bfc8517de5b92d1711bbd105318de77f0fd80"
  license "Business Source License 1.1"
  version "0.3.1"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "8880687b61cd8c742d5a5f880bc72b68451dc5b3d5eb8bcaf903cf238462b4e9"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "a174bf8de2809d1d80f2307f4fa6a357f6d42b96b26faa6d9cec3e5781638f7e"
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
