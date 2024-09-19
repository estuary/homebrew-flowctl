class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "fd26c6054b5316ed863c8fe290fbc2febfc685c412296aa53d611eff5d01de42"
  license "Business Source License 1.1"
  version "0.5.3"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.3/flowctl-multiarch-macos"
      sha256 "56d66baef7a68f5dfe00dd94c91ea094eac64565696865358b90733710078701"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.5.3/flowctl-x86_64-linux"
      sha256 "b08da2740492544ac2f50ed350c73289c7acfe7ed1d67faf055a9841a254feb3"
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
