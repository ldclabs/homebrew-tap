class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.4.1/dmsg-macos-arm64", using: :nounzip
  sha256 "0494d55d87bc9b220ddf85c7ccb5c2a2d9e77297a194c55997e2bd6297fc8556"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.1/dmsg-linux-arm64", using: :nounzip
      sha256 "ee6c4cfc9ccc58fd17e1d1fc95c45f62a5762afade1c152a34d5244eff18dcb4"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "ed3c1b93839c1bcc62c63f2f9cf1ee4d91d3b1ab0a89509f2d7c7ebb9bcd007d"
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
