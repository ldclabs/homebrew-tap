class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.6.1/dmsg-macos-arm64", using: :nounzip
  sha256 "88ede22cdba046524a760e63d5b66fdadb94adff478e19a6b8db4db5cef77f56"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.1/dmsg-linux-arm64", using: :nounzip
      sha256 "ead00109b71e4bafdb68ce46699f6028d8b441cdd3b8cf5446073183c50aa320"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "517e062f8fa7454777dd03168804ce5babfdc5cc84c029e05134c1d0f94ca0e8"
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
