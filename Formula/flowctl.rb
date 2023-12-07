class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.3.11.tar.gz"
  sha256 "fd4157f3e0077af58aeca0da4e8dba7609748e766e2362e32bf8704fda0f2231"
  license "Business Source License 1.1"
  version "0.3.11"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.11/flowctl-multiarch-macos"
      sha256 "dfc5e21c5ca4e0e80ea3cfbbacf922ffb44a5bd344b96f64e178b0184af680b1"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.3.11/flowctl-x86_64-linux"
      sha256 "ed240981eea888edc96409f8652b445c3024eb61253939be28c0712cc40b526a"
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
