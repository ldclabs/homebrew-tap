class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.7/dmsg-macos-arm64", using: :nounzip
  version "0.2.7"
  sha256 "e37880ffb3482ff6b09dd0b4e51c580b05c4b2e1f67e138bc51d4883f08788a5"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.7/dmsg-linux-arm64", using: :nounzip
      sha256 "33f78302a07738291ce5cf475953552af7b3aff23784a795caed45bfe98cd4c9"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.7/dmsg-linux-x86_64", using: :nounzip
      sha256 "08d9d95e01e82cdf9003b737bb2625f4ff6e59c7301de465718a893a137cdc5a"
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
