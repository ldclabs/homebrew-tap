class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.3/dmsg-macos-arm64", using: :nounzip
  version "1.1.3"
  sha256 "fdb38857a205e4887466685e59bdbe0251a78443d066ddc1447a6af7ca566712"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.3/dmsg-linux-arm64", using: :nounzip
      sha256 "a537fbc8f0633a35b73d4c398a314e3219311630f8736067a61ab49760a64d3f"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.3/dmsg-linux-x86_64", using: :nounzip
      sha256 "35a31c176cda0a41fec71087c24c73f1854facb3814a0364d88331ac883b3801"
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
