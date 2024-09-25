class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "9bf9f8ee23d8580159959f156cb4ea7ce26eb9f0e6ee3f0363156f5f4b0f7396"
  license "Business Source License 1.1"
  version "0.5.4"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.4/flowctl-multiarch-macos"
      sha256 "70a1f9f6afcd089e5072a06ae3a672e90fba00bb9598b785248ca3877e34fd4d"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.4/flowctl-x86_64-linux"
      sha256 "c0df76ab18cf6fa65e23f6ee24ef03e20ef298a5f156d2c81a503bd2655ea36f"
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
