class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the `sha256` and `version` below!
  url "https://github.com/estuary/flow/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "0ab277515594c39d899f893350ee56bd9c33ea9ba5d630f7ea3ce35d4166af8c"
  license "Business Source License 1.1"
  version "0.2.1"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-multiarch-macos"
      sha256 "ec4af7bb0a620cdc413da94a9e7692105100f1f490c60e9bdb45d17b428ad112"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v#{Flowctl.version}/flowctl-x86_64-linux"
      sha256 "ede74c39494906d87dcc0634d9ef7a93bb707f72f0e8939be66d04efb0eb41a5"
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
