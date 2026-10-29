class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flow"
  # When updating this formula to a new version, you need to update this url as well as the "sha256" and "version" below!
  # For example: "shasum -a 256 v0.3.2.tar.gz"
  url "https://github.com/estuary/flow/archive/refs/tags/v0.6.15.tar.gz"
  sha256 "1c1d7b9aa79c46313d5ed588fcd8f3f8a8fcdc976df6c746a6f984ef883ad764"
  license "Business Source License 1.1"
  version "0.6.15"

  on_macos do
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.15/flowctl-multiarch-macos"
      sha256 "cde708122c6cb08173957e163078d36812c41da26e972481e3ee5ca8c160620c"
    end
  end

  on_linux do
    on_arm do
      raise "flowctl can only be installed on x86_64 linux systems, please reach out to support@estuary.dev if you need flowctl on arm"
    end
    resource "flowctl-binary" do
      url "https://github.com/estuary/flow/releases/download/v0.6.15/flowctl-x86_64-linux"
      sha256 "546cebc35b088c08d1a686bf4d0886afe83f490911a29b0de24d8ab06731f13e"
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
