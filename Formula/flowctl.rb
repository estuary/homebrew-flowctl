class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  url "https://github.com/estuary/flow/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "ac600022baa0dbbf7feba9763bf7f1dfc305f7ce5de0da9124fe46f055337fd8"
  license "Business Source License 1.1"
  version "0.2.3"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "c1dde70694372b095c6310099bb5ac7790bd8539eddd494af3c7644aec689d75"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "01d66c427fc57af7516c445a6c6b47aae873bc82d5d99df18cd49dc7567cf412"
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
