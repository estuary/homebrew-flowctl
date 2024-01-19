class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.12.tar.gz"
  sha256 "04a45341660acc5cd1b9bbcaef6dc4f96124f1b56b24aa727e894beefb64cc07"
  license "Business Source License 1.1"
  version "0.3.12"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.12/flowctl-multiarch-macos"
      sha256 "5943a139b8478c2959bb5f75cd44fc1a94cb1031c04a751dda888b6fa25be212"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.12/flowctl-x86_64-linux"
      sha256 "6956cac9b1013b1020b1214a79e96de2808132d94f476c3329b07476abb0dd6e"
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
