class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda-macos-arm64", using: :nounzip
      sha256 "eeb958dd7f0fba106b99b876becd3a5a8b7ea95b5dc80cdaffd385143f8866b1"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda_launcher-macos-arm64", using: :nounzip
        sha256 "133534cfada5643734f82468ef42e1bb6e7e04e7803f96d8b2a6849eff7cd4de"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda-macos-x86_64", using: :nounzip
      sha256 "2e3633c4c59e6a238b6e7afebd359cfc73ef9cdcbed0b895ea63a867e013f217"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "747214f7b6b19cbf05bb7ee6d2ccb8cfaf07996b21a520ef415e78bfb7d28d26"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda-linux-arm64", using: :nounzip
      sha256 "16d2d336b7a5332f441a50264a169100e2a6bfa47c7e174e107a776693d77dd7"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.13.0/anda-linux-x86_64", using: :nounzip
      sha256 "f8ce95ed902f69128d99b2085184f5bcde02d83cad7dfda7475e2452401df96a"
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
