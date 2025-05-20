class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.12.tar.gz"
  sha256 "89bb179b27269cfeda53c363c54465810db8b2311a46e6528e7d4419e0853799"
  license "Business Source License 1.1"
  version "0.5.12"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.12/flowctl-multiarch-macos"
      sha256 "ff39e24a90c4f14e754d146b288107853e52ac31a4568417eca6989ba4b72470"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.12/flowctl-x86_64-linux"
      sha256 "99d36df64b6cc1b8313655427f42a0633094f0fe133d48cec7a06473bee8d723"
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
