class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.19.tar.gz"
  sha256 "e1da358cc3b42e9ea5a1088d44f6cc36af681014e2b49249bb234526bffe68a4"
  license "Business Source License 1.1"
  version "0.5.19"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.19/flowctl-multiarch-macos"
      sha256 "db52f62891dffa2ab691dedc90aed4d0235435b76f4aec132a89998e9682f3a8"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.19/flowctl-x86_64-linux"
      sha256 "33476eb3d74177be1433327aac748c17fbcffc1e8675aa8305254ee0ff273809"
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
