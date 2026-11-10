class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.1/dmsg-macos-arm64", using: :nounzip
  sha256 "cb01180af677980b1eddcce131bb9f3496990cc5e148561da37e33d9b3a46b01"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.1/dmsg-linux-arm64", using: :nounzip
      sha256 "eb17e0fcbf787491f41c6747a798a655c7712a2d1fd2b031fed7c6a1622f655e"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "d41588fbe77664e5210e38d5c9c0f931a8de9d448b8798f76b054169e6185c5f"
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
