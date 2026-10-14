class Dmsg < Formula
  desc "dMsg client: CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.1.0/dmsg-macos-arm64", using: :nounzip
  version "0.1.0"
  sha256 "fa08fdd8d40a375fa1d0a1fbdb64b1fb833bd4ecf5484170305c1caaeead3f8d"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.1.0/dmsg-linux-arm64", using: :nounzip
      sha256 "23298d2cae563c7e0a3cc947f16a3b6b71f53ddf4afe21c1ac33091a3ca0b48c"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.1.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "a47fc5027cfe2c13402c1859e1d6082cab4e9d4397189cdd56081fb1110550ab"
    end
  end

  def install
    binary = Dir["dmsg-*"].first
    chmod 0755, binary
    bin.install binary => "dmsg"
  end

  def caveats
    <<~TEXT
      Write ~/.dmsg/config.toml, then start the daemon and log in:
        dmsg start && dmsg login
      After an upgrade, restart a running daemon to use the new binary:
        dmsg restart
    TEXT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dmsg --version")
  end
end
