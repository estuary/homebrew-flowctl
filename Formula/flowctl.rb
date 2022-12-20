# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Flowctl < Formula
  desc "Command line interface for Flow"
  homepage "https://github.com/estuary/flowctl"
  url "https://github.com/estuary/flowctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "757467ebb8aff45a9231a1ee017418d3e65e1b6b054554e6de34576975c6b95d"
  license "Business Source License 1.1"
  version "0.1.2"

  depends_on "rust" => :build
  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "protobuf" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test flowctl`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
