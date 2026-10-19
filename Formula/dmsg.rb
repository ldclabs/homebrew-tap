class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.4/dmsg-macos-arm64", using: :nounzip
  version "0.2.4"
  sha256 "f0035d080a0c22a66a645b11e4b643768494c8088fa0668db66dd32e537894f3"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.4/dmsg-linux-arm64", using: :nounzip
      sha256 "948c56749ecf3a32c170b4573681b0b7c53294b94c9ad3257298549fbcedb592"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v0.2.4/dmsg-linux-x86_64", using: :nounzip
      sha256 "024c47cc95aee0552f07bcf7080bfde2d9477cba4a8038bf8f278fbc50732dfc"
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
