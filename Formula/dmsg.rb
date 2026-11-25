class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.6.0/dmsg-macos-arm64", using: :nounzip
  sha256 "ec1279a68d02281c33c786de54688711869dca48c3c7f2de61506c2b658ba6e3"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.0/dmsg-linux-arm64", using: :nounzip
      sha256 "6e5915b483dcd71d325463bb29079c34c4f9e8847454880acfcb8919e58a88d9"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "40627ae00ef3b4a55541a7bca90ff3b493970fcf14104417ba9da163c4eb908a"
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
