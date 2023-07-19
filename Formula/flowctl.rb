class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  # For example: `shasum -a 256 v0.3.2.tar.gz`
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "823b1c3551fbce667aa42d877ae9b788d03c0bdc5292d4b831c812302d7660e5"
  license "Business Source License 1.1"
  version "0.3.4"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "383cdc5d9217e5a02cacec49d74a1eb125356b7b1d345a417a2032fd34e3c245"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "bd45ba2420223465f7e11ef44ab126f087853ed8ef1b25341ec0dd44baec4649"
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
