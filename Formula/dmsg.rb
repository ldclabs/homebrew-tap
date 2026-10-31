class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.1/dmsg-macos-arm64", using: :nounzip
  version "1.2.1"
  sha256 "d49a8a480cdcb2784ca9dbf7d53734831a0ebd942901ae0ce1ca59df24839da7"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.1/dmsg-linux-arm64", using: :nounzip
      sha256 "d3dcb7d1b3daf0592c5a08e73c0d54f06aea334279639d497db7d8c3556413d7"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "f395a5aa62c0c4dcb7685183d403873f6d86a4a06fc56b23c97f762e1b76885d"
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
