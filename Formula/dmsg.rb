class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.0/dmsg-macos-arm64", using: :nounzip
  version "1.2.0"
  sha256 "83de1c8a0b2c40ad74f200d1fcb7726704b3767a8cf061b46c0d9a592c54bb0e"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.0/dmsg-linux-arm64", using: :nounzip
      sha256 "792e00f8ccadfc6fb3bcb1c75e755556eba0da0e284ae4bf37548ada0e06e868"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.2.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "6d74c6d7034175cc75cc3f289804452ef30715a60d5b5c645d972bd370576cb2"
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
