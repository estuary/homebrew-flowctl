class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "9c3df23adfe6272da9b5d06d006d68b5a05469bf893cfd1c005b6768f0f63ab5"
  license "Business Source License 1.1"
  version "0.6.3"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.3/flowctl-multiarch-macos"
      sha256 "812026f3c7430742609ad15ced75d46cae10daf162385a557f12305515fcde49"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.3/flowctl-x86_64-linux"
      sha256 "b737423cbb42fcd21bb15c05bc8d5190f9b0c60489e12b5a465034e2fca047e9"
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
