class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.1/dmsg-macos-arm64", using: :nounzip
  version "1.0.1"
  sha256 "a6d3a81d31b9d526d24032fa5e94c83df67fbe7194d4edb72e98843a6151b537"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.1/dmsg-linux-arm64", using: :nounzip
      sha256 "12ab35a8b9fa8769eaaee00e96cceff1284180f190e961f9aca1101549a163aa"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "e28aed32b8657afa6d715dc0e836f216b89bcee94fc7cc0611229596bb67b763"
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
