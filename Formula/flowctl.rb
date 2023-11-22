class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "88485235d1ee2ea4eef6bb3e5a6e6b0572f3baae59dea74a53ddf3a67bc0c9bd"
  license "Business Source License 1.1"
  version "0.3.9"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.9/flowctl-multiarch-macos"
      sha256 "8fac1c38913d4d5426bf812c0eab8935c8ee04125298b2137a585857ec455c5d"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.9/flowctl-x86_64-linux"
      sha256 "da8776f74334fdeee88201504e7047ce12f0f4d1016375287f34b8acfd3e42e0"
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
