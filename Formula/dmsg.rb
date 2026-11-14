class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.7/dmsg-macos-arm64", using: :nounzip
  sha256 "5329190dc5ea5d20637c4f88c7df7e6f70e2c025cfcca0b2dc38b2bc6de7270d"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.7/dmsg-linux-arm64", using: :nounzip
      sha256 "fd470c612153a91cc746ae8115f7215c9fea284d07b8eef615191577e14ef6be"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.7/dmsg-linux-x86_64", using: :nounzip
      sha256 "93850ad17ddc1a0b83b9b0ac48b8be135a02d34ffe97b517bb7a9be9d3fc95e7"
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
