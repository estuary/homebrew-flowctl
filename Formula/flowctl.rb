class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.6.tar.gz"
  sha256 "1297630b47686fba0319b84680fe60350b3ffc1aaf22d4e8906a75bc2ed4c6ee"
  license "Business Source License 1.1"
  version "0.5.6"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.6/flowctl-multiarch-macos"
      sha256 "aeabd3dcbbdbccd9277e9739f1de595ae21421e771d3b68b2ab5b66a3a04063f"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.6/flowctl-x86_64-linux"
      sha256 "a93f0907f7f40276e0bf918ec8315d03681dc07610239add3a6c89c28df3b3c2"
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
