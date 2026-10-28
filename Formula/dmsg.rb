class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.4/dmsg-macos-arm64", using: :nounzip
  version "1.1.4"
  sha256 "f1bc90a095df59e79a40b7e1af570ec5bc6d3e6d192450c7af0b7de8deebdf36"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.4/dmsg-linux-arm64", using: :nounzip
      sha256 "ea350c513eb6386630ee7756576e3e5c4ca2e5a1ef419a06802bd94917b9628f"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.4/dmsg-linux-x86_64", using: :nounzip
      sha256 "516b3ad31e4aae76b62a83f44fe32f498d78964a2d41c16aedf725a31dae5d0e"
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
