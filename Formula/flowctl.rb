class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.14.tar.gz"
  sha256 "1fdc2788bf953403a467761fa1e6dfd0ef9fbf204d142c3c97b2d963ad1ae95a"
  license "Business Source License 1.1"
  version "0.5.14"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.14/flowctl-multiarch-macos"
      sha256 "43cb1eb7ffa4415054fe271e4773072431383f557e00f1de130336eb7c3f8c85"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.14/flowctl-x86_64-linux"
      sha256 "49390e533560b3b8b0167337582dbcfd472b5f9f32dc8fd91e075f8f8a8c323f"
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
