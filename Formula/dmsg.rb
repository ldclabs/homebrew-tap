class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.0/dmsg-macos-arm64", using: :nounzip
  version "0.3.0"
  sha256 "29cba216919593ebfa73fd73436cbc249ccab744201506cc0e73569397cd7e6a"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.0/dmsg-linux-arm64", using: :nounzip
      sha256 "237634df9300c1583915307ba48ca15fd72c2a22d730d0bd81aa95e36df824dc"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.0/dmsg-linux-x86_64", using: :nounzip
      sha256 "79c8f968cfe994bedb5f042d59412e763d0076f36139ace660476862277bf6ef"
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
