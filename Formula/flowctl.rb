class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "34bb5ca621dfa4baf488ac512e89397b4decb80038009edfe3325096cf4b47c1"
  license "Business Source License 1.1"
  version "0.6.5"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.5/flowctl-multiarch-macos"
      sha256 "78c0c9826101ee88898b234d7a070865b29da94f3c8fa7da39ec27806c48e451"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.5/flowctl-x86_64-linux"
      sha256 "c150e7b61bb9f6e99f65d364950f4addc193eabc0a25b53ed7dccb40d47b6826"
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
