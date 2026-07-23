class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.12.tar.gz"
  sha256 "67d7436ba8a0f82e7dd6de87f4f63cf098ea5783e76be438bca82882f2faa08a"
  license "Business Source License 1.1"
  version "0.6.12"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.12/flowctl-multiarch-macos"
      sha256 "eb2f72ad0e187ee4417d64536fb320f1c0782c0a5198207907ab0ec142211c4d"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.12/flowctl-x86_64-linux"
      sha256 "0edd24b69c708a967682967e4eb396296d57a60cbbd140c6669eb6c0a5576200"
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
