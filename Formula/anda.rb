class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.5/anda-macos-arm64", using: :nounzip
  sha256 "3169695c6b8eed59d5957a0ea88ee8f3d1c2dc01d51b354a0d91a848df553e25"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    resource "anda_launcher" do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.5/anda_launcher-macos-arm64", using: :nounzip
      sha256 "fc7950ba745bcfa3e7a8d56d875313e12286bc56aeaf1e516ec4d2f14a75bff3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.5/anda-linux-arm64", using: :nounzip
      sha256 "f94aa1a7ed07c7e2db43425465925cbabf1ffe1ea268a65641922d71510a20ab"
    end
    on_intel do
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.14.5/anda-linux-x86_64", using: :nounzip
      sha256 "acb5b9e6328c3080041cd49300bc0111db6d2e646ce447be534c1c01c0e2f9a5"
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
