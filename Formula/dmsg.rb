class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.1/dmsg-macos-arm64", using: :nounzip
  version "1.1.1"
  sha256 "b2480b70d401286bde9a185202ddacbf11142076c2cfac7628352564843c497a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.1/dmsg-linux-arm64", using: :nounzip
      sha256 "b05426b5d2a1423031061517be34d2c4c009f47da2c09259cbd00f1b0111916f"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.1.1/dmsg-linux-x86_64", using: :nounzip
      sha256 "96a6e9d49f684b6d019eb6a1d1a156295ed1128cb8e4f13e07d1502e1b419aa7"
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
