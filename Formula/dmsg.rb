class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.3.1/dmsg-macos-arm64", using: :nounzip
  sha256 "0b9e805e93dd7a47225c1f55c0a48bb789e0cf23044058a019d6b542b84791c5"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.1/dmsg-linux-arm64", using: :nounzip
      sha256 "e49a17c8ccbb397465049d9a0eec580435a0ad9f5a5dcbc1edb0308968078085"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.3.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "87830ee4b30d109838ec4080f463fe880364fec7934a1c907ce950a3d0f236c9"
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
