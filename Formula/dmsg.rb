class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.8/dmsg-macos-arm64", using: :nounzip
  sha256 "72c9503c21c489dbef1626de266f25b21ac8009405542192ee5244d6eb4780c0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.8/dmsg-linux-arm64", using: :nounzip
      sha256 "4b163a20c6309aca7e03e02c404916ef5ec3d0275421eddb9abbada6f3f026fc"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.8/dmsg-linux-x86_64", using: :nounzip
      sha256 "3bb2907bcf4be91f62be6e7afb82996a6d92d7950afcce6793ff2238d64ebd7c"
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
