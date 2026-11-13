class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.5/dmsg-macos-arm64", using: :nounzip
  sha256 "df59e2d17fc086cb91cb34d73155e78657e327dcdee80f059cb735063865a77e"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.5/dmsg-linux-arm64", using: :nounzip
      sha256 "be81a9c5db7d26456c4a6e9cd5ddc6dfe4e5cace2dac0f006c64c6d04a42bae3"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.5/dmsg-linux-x86_64", using: :nounzip
      sha256 "72909ef9c448f28d58efda7b972ac19bfd3829a8bafbeb75c707d72314a2e6cf"
    end
  end

  def install
    binary = Dir["dmsg-*"].first
    chmod 0755, binary
    bin.install binary => "dmsg"
  end

  def caveats
    <<~TEXT
      Start the daemon and log in (production; ~/.dmsg/config.toml picks
      another deployment):
        dmsg start && dmsg login
      After an upgrade, restart a running daemon to use the new binary:
        dmsg restart
    TEXT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dmsg --version")
  end
end
