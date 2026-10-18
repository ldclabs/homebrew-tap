class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.2/dmsg-macos-arm64", using: :nounzip
  version "0.2.2"
  sha256 "2ef19bed1da9dd461597d3b42c366c682a5263d7e853b40378d52a267db18c01"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.2/dmsg-linux-arm64", using: :nounzip
      sha256 "968270a2bdd5ec8f03949039f207567d39f6ed982600ea06cb9a09c23794ced8"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "96a3e45617b6f19474d2544d6eb3466f9af534d05b2cdd0745f11a6092240561"
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
