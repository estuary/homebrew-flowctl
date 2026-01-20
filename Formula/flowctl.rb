class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "08b04e3fa3a18ddbc6b7deca32648ed9384c079a57e807be87bd59d0b1cee55e"
  license "Business Source License 1.1"
  version "0.6.2"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.2/flowctl-multiarch-macos"
      sha256 "c7f0b9e3ab7ea208bedad8aa9185169ee85e44f68fc8244fc4c0ee07fa974878"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.2/flowctl-x86_64-linux"
      sha256 "e39ff1dd29d6fa543fb876a17061667eb244f65e5f7ea6b8c60b2653dc67995f"
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
