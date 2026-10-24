class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.2/dmsg-macos-arm64", using: :nounzip
  version "1.0.2"
  sha256 "fa0c106a2381f3ca5df2bc950096c8eaa3f2ff38efa8c32ac0dd69096a8a3005"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.2/dmsg-linux-arm64", using: :nounzip
      sha256 "e97a3d402b3b1f4d995e03774bb9c98abe3d2c6b100a03172a5e438fbf68fce4"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v1.0.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "0b2e89a374809d31eeb13ea79c1f88cd27e8d6875cae8e9e40d0cb1dcbaf36d2"
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
