class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda-macos-arm64", using: :nounzip
      sha256 "cbcdf651ee1fdb78352cfedf415a448be340e76498e258666e153823e94cc87c"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda_launcher-macos-arm64", using: :nounzip
        sha256 "35efca16ec1bd1e8bad5988b376e4cacb034a1d2ce6ec9dd61a57d3f9a44b585"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda-macos-x86_64", using: :nounzip
      sha256 "0892ad0c92f1c3b92a2aefe13cab67a2efaabb7686ca35544cd0d474c02d01d0"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "25180e6ca8c6cfaff1922532083909eddc2227524b217da04074520fb627046f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda-linux-arm64", using: :nounzip
      sha256 "5b11a0521f0f014a4fbcf5457b7c749b811f8ae7902af7eab2eecd8205595da0"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.12.0/anda-linux-x86_64", using: :nounzip
      sha256 "b6bda69ff2f81f91b2139c12a6427c57ce5c62c6472ccca89f6be1a506b4bdd0"
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
