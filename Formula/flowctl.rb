class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "8fbb6b2f9b45bf99cf541a06f4d6f633d0f8aba5c269ee2e6316a9ea545cc15d"
  license "Business Source License 1.1"
  version "0.6.4"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.4/flowctl-multiarch-macos"
      sha256 "389fbcac3cd4d81c18ab58d16ae37bcd1de647a4a92bf0c7e6a5fbb6443f3fdc"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.4/flowctl-x86_64-linux"
      sha256 "d5462e8194f5a9fe8c59924911ad06066b256546623a384f75be2d6933d3bb51"
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
