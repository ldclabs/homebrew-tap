class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.2/dmsg-macos-arm64", using: :nounzip
  version "0.3.2"
  sha256 "e692aa1f8cf6969717bbe1549219131283bedad96e8cba15954fe79dd990959f"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.2/dmsg-linux-arm64", using: :nounzip
      sha256 "fee6323ee1af2692cd472c1495198cd95a9238bbda5b5fac84b25dde14e380f9"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "0d782eb79c5d44383b3a3cfc88980f17d114d654c9fd3d0c2afdbdf657da2a06"
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
