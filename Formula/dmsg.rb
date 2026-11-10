class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.2/dmsg-macos-arm64", using: :nounzip
  sha256 "4019b85c20128295579c96ce06f01e769c0256467017c2141cfd6127fec3128a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.2/dmsg-linux-arm64", using: :nounzip
      sha256 "a3688f3638330ccb2c0d900d2ba561264845df54b795260fa4e44a4df90cb097"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "911dcc60c7d09454e9820ddefb52ec5f4447ac963f020b1810baf6e6f2c909e4"
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
