class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.3/dmsg-macos-arm64", using: :nounzip
  version "0.2.3"
  sha256 "ddccfcd78fa90ac2150b37d464fd0ea9d9563e6f2c9cdd147551b59b403641eb"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.3/dmsg-linux-arm64", using: :nounzip
      sha256 "02ef06ce37ea2fafca74ba4aff8627fccc224c8cb2dad6a01ee3c05e88b74d12"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.3/dmsg-linux-x86_64", using: :nounzip
      sha256 "9e1077fcfd920cd4559bb7f306f5f506d7cb5aa4a6a4722aec1c72f3dfc4c7a2"
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
