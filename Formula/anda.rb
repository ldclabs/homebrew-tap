class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.11.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda-macos-arm64", using: :nounzip
      sha256 "fd07f16e3acfb8fe95c5eb43510085d9610df770e2f51713ac4a300c607984c5"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda_launcher-macos-arm64", using: :nounzip
        sha256 "6cae463ee9f564a722a49ab101183279f65d2f20165438ff531c810f091ef871"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda-macos-x86_64", using: :nounzip
      sha256 "b566556afb79886ece8bf24490fd09bbab3c80a53d460ba685ae5f2f04441bbb"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "4a076a2eca49c31a466064c7b9d1a58ec94b5448e2daafcfda78ac2be78b2326"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda-linux-arm64", using: :nounzip
      sha256 "b8059f30b8c080eb42b98b5d6e7036c1fcfe3f98eb364ee854cf29194cb02689"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.11.0/anda-linux-x86_64", using: :nounzip
      sha256 "28984bce7b9dffd60275d98d00133e98160abe1d0c1715b2c387aebe5681ded5"
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
        "The macOS formula also installs the menu bar launcher:",
        "  anda_launcher",
        "Run it once to create or refresh ~/Applications/Anda Bot.app.",
      ]
    end

    lines.join("\n")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
    assert_path_exists bin/"anda_launcher" if OS.mac?
  end
end
