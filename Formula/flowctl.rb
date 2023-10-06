class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.7.tar.gz"
  sha256 "7682a99f4dc13024c7f1116ff8488cb206b0afa290126cff88de809f38b90b6b"
  license "Business Source License 1.1"
  version "0.3.7"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.7/flowctl-multiarch-macos"
      sha256 "196d4c89c3116e0dea288c8fda357c7af4ca964050fa27a770a5f7210c74c07f"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.7/flowctl-x86_64-linux"
      sha256 "3b8b468c9b82fce7685d961550e42dccf8c6e9b13d1bff395889ea353db57fcb"
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
