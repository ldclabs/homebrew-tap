class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.3/anda-macos-arm64", using: :nounzip
  sha256 "2cd00b36b36ad5141592171fc6c1d4bad5a0270d4d8801da2522de393c4b5358"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.3/anda_launcher-macos-arm64", using: :nounzip
      sha256 "f7b8f8110be44b9b5a89bb995ce56cc59774c042ce8bb92f53058852a01e36f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.3/anda-linux-arm64", using: :nounzip
      sha256 "b62c12e4c6d0cdc35592b851bc66f028374cf06e24ac8cfd9481a454931bc45d"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.3/anda-linux-x86_64", using: :nounzip
      sha256 "d30127bc13bd6d1194364c8a84bdd2ce8753a4371d3de61c5547aca2e7914bde"
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
