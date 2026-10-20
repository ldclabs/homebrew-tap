class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.5/dmsg-macos-arm64", using: :nounzip
  version "0.2.5"
  sha256 "b6afa0828b3d8c942f03b78433c1f766cfb27a288a243d784020ba93224344b1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.5/dmsg-linux-arm64", using: :nounzip
      sha256 "09dea933de804eb5ce36df2c1db037d2c91752e1141fe608f7c9e05825efb7eb"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.5/dmsg-linux-x86_64", using: :nounzip
      sha256 "0925b21d995e53191599071d9c13ca11ac4e18e4d7f15f9b5904adc41f465b99"
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
