class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "ee16584353ac552795fdbcf66479fefa0f26251be0be4acc47dc81c69548270d"
  license "Business Source License 1.1"
  version "0.5.1"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.1/flowctl-multiarch-macos"
      sha256 "f4788e6cbcbb22810689615351bc7b7bad53bc5d60cf41462bd9846d1c496ba8"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.1/flowctl-x86_64-linux"
      sha256 "2f1280dd3c49e2fe654344be66395ec2ca50f0f04fad5757319366bbba47e0ed"
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
