class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.22.tar.gz"
  sha256 "6a0cda1e3322235d436c81029239f6318ef64b2267c4e23fdedc2cf93039b5e6"
  license "Business Source License 1.1"
  version "0.5.22"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.22/flowctl-multiarch-macos"
      sha256 "f851b9ea5e91ca933b2e9cc7bde46f489d58500c9dc3ab2d3f1e9d863049abd9"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.22/flowctl-x86_64-linux"
      sha256 "c39589d603d7229d9db9cbf6302bac8106f24505d4825ab6155efe9f16b6b3aa"
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
