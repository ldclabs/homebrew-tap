class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.2/anda-macos-arm64", using: :nounzip
  sha256 "439dfba385e2036e36b9b599ca6653bf74489e0def9e4bdac2d6d75397bffbf3"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.2/anda_launcher-macos-arm64", using: :nounzip
      sha256 "d93318b1d434ad9a5335b6ed9586aafaf4557a1740222983760cd4cfb0a4a203"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.2/anda-linux-arm64", using: :nounzip
      sha256 "385339bd3e73f0acbde96dd519f78076415b476e8039111e810c7a73b03c8769"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.2/anda-linux-x86_64", using: :nounzip
      sha256 "af0828d0a337e0ede03f0f045a0f21f9a2d016003b0277bd04b6131283aa7512"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"

    if OS.mac?
      resource("anda_launcher").stage do
        launcher = Dir["anda_launcher-*"].first
        chmod 0755, launcher
        bin.install launcher => "anda_launcher"
      end
    end
  end

  def caveats
    lines = [
      "Homebrew does not write runtime files into ~/.anda during install.",
      "To install or refresh curated skills, run:",
      "  anda update --skills",
      "",
      "After upgrading an already running daemon, restart it to use the new binary:",
      "  anda restart",
    ]

    if OS.mac?
      lines += [
        "",
        "The tray, chat window and settings are in Anda Desktop, which uses this anda:",
        "  brew install --cask ldclabs/tap/anda-desktop",
        "anda_launcher only retires the old Anda Bot menu bar launcher and will be removed.",
      ]
    end

    lines.join("\n")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
    assert_path_exists bin/"anda_launcher" if OS.mac?
  end
end
