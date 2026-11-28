class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.6.2/dmsg-macos-arm64", using: :nounzip
  sha256 "469092cf26535468f05ae3bd040024e50a3ba511342da5558561917d29a2cbc5"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.2/dmsg-linux-arm64", using: :nounzip
      sha256 "d2405d6c6a84f4e52ad5d7c64d9bf229c402ce15275c9176c3a159620cc3e941"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.6.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "6ff833cdf69c7426f16924dacafb08574faf7422e95d5b46bcb41bd3e3d12efa"
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
