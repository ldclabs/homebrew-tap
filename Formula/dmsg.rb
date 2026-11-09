class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.0/dmsg-macos-arm64", using: :nounzip
  sha256 "adc21c566534b12ac6f52ffdf85fa10458b69ee4066a43e4dfa06fbe04e42e63"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.0/dmsg-linux-arm64", using: :nounzip
      sha256 "423f66a31aad3de308a22367ec464c9a8965fd84358884d37e9943c9411ce819"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "3450942fe04c9c4a038846a9d3a43c1da68a5078e92c0d2d80a6403078249763"
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
