class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.0/dmsg-macos-arm64", using: :nounzip
  version "1.1.0"
  sha256 "d43f9b6beb90b528c8778164d765379d32cf54d2a29f7919c9c2d546d21dc5e3"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.0/dmsg-linux-arm64", using: :nounzip
      sha256 "e654fee9723937de5177c68072bea9af74b185bd6bdacd24c858decd8077527d"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "cbb6eb86d15772b391a1e0c892e0826f2471b0443bb4557025bd889a8e1e7ac7"
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
