class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.3.2/dmsg-macos-arm64", using: :nounzip
  sha256 "9d9f28e6a239be33907a4fc7f71a59cc5dcd4327b079352afb12672a73646121"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.2/dmsg-linux-arm64", using: :nounzip
      sha256 "4bde18cf53621e53de603a3eb29db70807465bbdfaa6d62a246aea66ff993c94"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "e3d306d6a173b9662967ed0af24be2b9395e34a1cb51fa20a7f8c14477039c9c"
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
