class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.3.0/dmsg-macos-arm64", using: :nounzip
  version "1.3.0"
  sha256 "04730a307af7c64843d856e66b2906f2c26462779e980004200102e331331ff5"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.0/dmsg-linux-arm64", using: :nounzip
      sha256 "b51d73753d55640644702520bbc3c4fa248db71ee8d3503ccff5d18c0d88b606"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "ec2eb1165a84d5393a6311f634d3f5befcf55b47cc56bd17c169b8a6635de1ad"
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
