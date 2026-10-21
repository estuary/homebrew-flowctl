class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.14.tar.gz"
  sha256 "9a7274bb4eca4a9f4fc433b04aeeece52a55b053888700663ca1965eff64c23a"
  license "Business Source License 1.1"
  version "0.6.14"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.14/flowctl-multiarch-macos"
      sha256 "0e178fbc26c9ea812e0c24376e77ee3bd85040c6193d96b730d4aea7190e2b21"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.14/flowctl-x86_64-linux"
      sha256 "c1479761b8ef2ed3fc5b18bb65a5a1edce96f40d063b7010b88426b1fe304ae4"
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
