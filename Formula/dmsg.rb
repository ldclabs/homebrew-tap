class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.6/dmsg-macos-arm64", using: :nounzip
  version "0.2.6"
  sha256 "8e826331a15f8caebf666e8965bf23deeff0cfd9f4bd4686a84464c1e8e931f2"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.6/dmsg-linux-arm64", using: :nounzip
      sha256 "c66a0c074ba5b5730dd5896941ecca946e8ad9af74595e8948942b88520c1587"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.6/dmsg-linux-x86_64", using: :nounzip
      sha256 "6543e24a7321a31852e838a1bce0bde96bfcb117cabbf42c18fe034d117ab7fe"
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
