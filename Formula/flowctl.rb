class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "6173089e4ef1aec1c381d54acfd34907252fed7df24dccad43815519b941a519"
  license "Business Source License 1.1"
  version "0.6.0"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.0/flowctl-multiarch-macos"
      sha256 "5fe0b813d350a94321a8c47b963237e0fb3fe2def9bbe30887854bd09e85cbfc"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.0/flowctl-x86_64-linux"
      sha256 "943a68a5e90a6fb4d1a55b296a9d8e45bf273f7fcda7ccd262ab63fa04dc951b"
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
