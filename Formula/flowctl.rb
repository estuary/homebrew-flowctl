class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.8.tar.gz"
  sha256 "051b89d98d905af11443f7f129bae7ccd58d55b55d0afdec09880e0da2056c6e"
  license "Business Source License 1.1"
  version "0.6.8"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.8/flowctl-multiarch-macos"
      sha256 "cbf6a1ea8905841c085e5c7a259ec387213a4afb8309bcc625bf08fcbbccd147"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.8/flowctl-x86_64-linux"
      sha256 "2c64daa14099b351d32ca4ac5735b37f24c163573c5fdcf480fdada71958ca28"
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
