class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.14"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda-macos-arm64", using: :nounzip
      sha256 "02e106470c8b89d50ca5eaf5be722be1eafcebcb872a52e88e3d28b93bf98786"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda_launcher-macos-arm64", using: :nounzip
        sha256 "0c24bdd20b4b83980a2add5f726b9c1b35f80afdcdd9e5645c89bccc7537226d"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda-macos-x86_64", using: :nounzip
      sha256 "f8fc06752ce0805954c2aba8d078a910e7247b3266255f559286f92a026f121f"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "25a7cbf058a1a81936a37b10c20944c09663185c7cb0f5e619997cf7fc9a2ae6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda-linux-arm64", using: :nounzip
      sha256 "784944b08f68ac9a3ed9573aa8108d1e372d8d9cbdf0bad8daa14a838e56e2e7"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.14/anda-linux-x86_64", using: :nounzip
      sha256 "687230af854bee4f80fb4f8496e2f1ad5ee86a05706ad5bef78da41a990799fd"
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
