class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.4/dmsg-macos-arm64", using: :nounzip
  sha256 "c47eaace273f887f175082146bc6199bace846590a443ee36c3e640150eaa95f"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.4/dmsg-linux-arm64", using: :nounzip
      sha256 "59ef9d1ab9309b7cadac8303daee0e30f0e9a8f27b8f2ded13ddcb6a150bc0d9"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.4/dmsg-linux-x86_64", using: :nounzip
      sha256 "b533b33e1550ad82e347736714d6d813269c80933df9cfcc58e7d40c7d630274"
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
