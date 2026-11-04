class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.3.3/dmsg-macos-arm64", using: :nounzip
  sha256 "05982766af087e4caef9f047a8fa93f9eed33932778c20a541636d5cff110d2f"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.3/dmsg-linux-arm64", using: :nounzip
      sha256 "a82e014aac75f5742b2f404987068007bedb3c24af5f418d08f78ddfdfb827e0"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.3/dmsg-linux-x86_64", using: :nounzip
      sha256 "aa204cdd36477947121ddba5f7483c181620539c8aff8706fb5a300be3d66087"
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
