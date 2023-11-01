class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.8.tar.gz"
  sha256 "213526075da5fc271ce8c3ecffc89f7b82e90a92246c103c283c8cfab5721c7d"
  license "Business Source License 1.1"
  version "0.3.8"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.8/flowctl-multiarch-macos"
      sha256 "3d6905798704c0e03b3467a9703fe01aa5ab6f48549d1e2e3778fb465f6ceb1a"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.8/flowctl-x86_64-linux"
      sha256 "d71138790e953375eff4f258ff43c412f445330b1555f6313afecc9fd177fb0a"
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
