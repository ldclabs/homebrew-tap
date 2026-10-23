class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.3/dmsg-macos-arm64", using: :nounzip
  version "0.3.3"
  sha256 "4aeb8fc1c957c200a3d5cacb36d0e0bd56b564e72cc40b39ee4645011619cd07"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.3/dmsg-linux-arm64", using: :nounzip
      sha256 "5e5c7a4e86a2a2323e32d97e2039bc96c61c8e478e1ce3cd61bd88ad2be6eed4"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.3.3/dmsg-linux-x86_64", using: :nounzip
      sha256 "b1439f193a340b6cdbb8dc1725ced9549571668aaf1d36c9f856c26a158e2576"
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
