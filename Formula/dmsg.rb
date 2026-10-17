class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.0/dmsg-macos-arm64", using: :nounzip
  version "0.2.0"
  sha256 "50d2d387a1698653189bf580213ce29136019f3df6664b1f0444e9def2c0fa7e"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.0/dmsg-linux-arm64", using: :nounzip
      sha256 "8ca3938c7b86fc7427829fe1ebbd2da97c72e25eddc0e3ac55a2821f0633de83"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "08ccb9a1ebcceec712a97058d1357e2bc3fd8d9d9a1c210e6c8fa5d8359d88f5"
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
