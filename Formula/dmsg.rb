class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.1/dmsg-macos-arm64", using: :nounzip
  version "0.2.1"
  sha256 "da6f14b9447627793e01b1d9ea93b90a586e9aef673ac4249669ae8476833255"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.1/dmsg-linux-arm64", using: :nounzip
      sha256 "320d0dd83f2a1722d109fe8ecd64f6b988cda01425284d3e6e796d30a8677dc1"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "1c962f2120cb354d6fce6e5e74c475bd9057aae84f7ef49d9c8525dadb65b9f2"
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
