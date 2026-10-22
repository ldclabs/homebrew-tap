class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.1/dmsg-macos-arm64", using: :nounzip
  version "0.3.1"
  sha256 "9bb0b8455fe7b04400e3991d4eeed8d9a2b4b2744de6a718dd67a50f698e7497"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.1/dmsg-linux-arm64", using: :nounzip
      sha256 "5254b20e83bb287ddd80670c6865f7e8d17e2735d30bf57b94ff8e947e3d69cf"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "6d7a9a73e5e9f128605a242137cf42316613afea612804e995b7ff9b9112f62a"
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
