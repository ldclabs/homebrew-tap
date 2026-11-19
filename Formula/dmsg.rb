class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.5.10/dmsg-macos-arm64", using: :nounzip
  sha256 "a329e5157827bb191c9ec709488f972b24924270cab3bb5d6992e10f1ee1481e"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.10/dmsg-linux-arm64", using: :nounzip
      sha256 "df91a9fd7b9f2bcc192cb2059b06d0932a95e80555995c4759f0023646b748cb"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.5.10/dmsg-linux-x86_64", using: :nounzip
      sha256 "f189bf4351ea68a4a729b42d7a3cf23fc60a43f3d27c8444f91c21c3a8b02856"
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
