class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.15"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda-macos-arm64", using: :nounzip
      sha256 "d2941a15e859de9d1b19e76af7a67cf589f4d5342d36b3f7fc9aba29d03b3e40"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda_launcher-macos-arm64", using: :nounzip
        sha256 "d5f48a58b1bf9c1b4273f0402f8a03da2742e3660194b5d5e1dcfdc9116813ff"
      end
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda-macos-x86_64", using: :nounzip
      sha256 "0194bd6e0cd1529af398cc9785de0eb8545cc8ff035684de03023555784d57fe"

      resource "anda_launcher" do
        url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda_launcher-macos-x86_64", using: :nounzip
        sha256 "b772ae77f6eba0ff2218e109c90c108a7f2bdde761a61c313cb9c0e16693804a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda-linux-arm64", using: :nounzip
      sha256 "66caa640c6bac0480aa79074e3891baf12aab8352fbf55656775b398d0d1ca7f"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.15/anda-linux-x86_64", using: :nounzip
      sha256 "094b5eeb7455b7f8e55ab84dd11bc60e6fa338a1ed496b09496d47944f0b9c19"
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
