class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.2/dmsg-macos-arm64", using: :nounzip
  version "1.1.2"
  sha256 "613f7b39fe6ef2d2817d37fc9c19b40837492249fbf55022ea396852684a0bc1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.2/dmsg-linux-arm64", using: :nounzip
      sha256 "26c814652d6fadb5977b7e70a5f9633cbd8aa2cc2ec48327f1c5dd70dac8cd6b"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "b4cf201a28958f3e1f0eee211e4e8b5226d4483734b038953f244a9dbcc8902b"
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
