class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.0/dmsg-macos-arm64", using: :nounzip
  version "1.0.0"
  sha256 "ed674768952909ec281625781313660b13d435520ef37d5d0af8f348ce786204"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.0/dmsg-linux-arm64", using: :nounzip
      sha256 "a7047795d1d4a320085198c8d87bad73691c2502ac7a00e43ac6245357b97995"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "ae01c3342e0571daf40f5e15891eacbab9ca28fc590b7151d1f037e793cc53a1"
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
