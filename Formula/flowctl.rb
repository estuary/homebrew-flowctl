class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  # For example: `shasum -a 256 v0.3.2.tar.gz`
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "c7b2b49dd8d1a9048d6c799bb85fc838b129356675a5b098453a8be0cf9b49d7"
  license "Business Source License 1.1"
  version "0.3.2"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "e832d724d9583ebbcf16d73e6a2c2fbf8bd672f75ac75e0c341d659c14821961"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "44b9a544c77511bcffa6bdc6aaf5fadf9e2f38a039eca902c23bdfeca4ccde83"
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
