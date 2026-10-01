class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.2/anda-macos-arm64", using: :nounzip
  sha256 "99a810131ea487f22454cf0386bb16ff6436997b3559dfd89b31a4f29573e05e"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.2/anda_launcher-macos-arm64", using: :nounzip
      sha256 "fc3119d2f4a4fc2de547440f8245381533142c83175496571e3b8d87228e7689"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.2/anda-linux-arm64", using: :nounzip
      sha256 "96be7e4ce2144b8aff1f3ab47ab2debf74f65dc720d3529d0cb1766f6620dcc6"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.2/anda-linux-x86_64", using: :nounzip
      sha256 "ea8d111ca684277bc3b397caa307ba86a5cc96e5dcb82f73ed2f42ced1a9a01e"
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
