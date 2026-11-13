class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.6/dmsg-macos-arm64", using: :nounzip
  sha256 "a3678214f4624b4f1402c54c49933998d6077a22ada80f0bf5d26a55354b3461"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.6/dmsg-linux-arm64", using: :nounzip
      sha256 "49f2600401b941e82d1d7be2dd1d0881af02f73396ea977a5c94115978c4fb53"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.6/dmsg-linux-x86_64", using: :nounzip
      sha256 "fc5c9bbe960d5cccf378a29890de49c2f2d43801a1a368191cae691557e674d0"
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
