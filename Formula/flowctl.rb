class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "688f569e673a2114a8a1e7b5160b615ac8ecbaebc0f10030750dc1285e9db7b2"
  license "Business Source License 1.1"
  version "0.3.0"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "4a390e92be3bcd4424726ca72fcd03ffb545b973cc6c29101019a9078f78f3e5"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "24d69afbf8f25b8f229b42101b5bcf6fd16be5a21c4be840c1240831b162c684"
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
