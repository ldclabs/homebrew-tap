class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.4.0/dmsg-macos-arm64", using: :nounzip
  sha256 "8f21bf8996f496433f537fd8914bf528e893566bb82a04a0dfa14fb147a34aa7"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.0/dmsg-linux-arm64", using: :nounzip
      sha256 "96cf4bbd07b49951fd08b127e36177d8a63b35f2560b182a635cb9e2d1c86fab"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "1ea5c3058569a4e8ef793afdc78ed04e7351b882832a66b92669301cce27002e"
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
