class Dmsg < Formula
  desc "CLI and daemon for the private dMsg workspace and its agents"
  homepage "https://dmsg.net/"
  url "https://github.com/ldclabs/ic-panda/releases/download/1.4.2/dmsg-macos-arm64", using: :nounzip
  sha256 "c2558092518974e039cf069140c3be182a2286b094e6fe6a4521a4e11d76d4e9"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.2/dmsg-linux-arm64", using: :nounzip
      sha256 "223fedfd2cd1d464ad01ef7c27f50d90bfad6520940e2639da701a795ba29909"
    end
    on_intel do
      url "https://github.com/ldclabs/ic-panda/releases/download/1.4.2/dmsg-linux-x86_64", using: :nounzip
      sha256 "a147f95e8fc0afb6b8f3b018d3a5ca353c99fe54a787684ca889e44eec09d55e"
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
