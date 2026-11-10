class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.3/dmsg-macos-arm64", using: :nounzip
  sha256 "2fef423e78d3761b1810da41314c3e46338bf9eec55dc18c1bae14a17b01f496"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.3/dmsg-linux-arm64", using: :nounzip
      sha256 "4392f573a73377ec458944f3e37c2a2db19419a3ba17c9911f3a2beac905d278"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.3/dmsg-linux-x86_64", using: :nounzip
      sha256 "e1feb907f7e4e7a0e9fc45a64cddeb7351e1e9d4fdb4bcbfee019d46b624c2db"
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
