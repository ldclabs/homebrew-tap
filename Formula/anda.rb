class Anda < Formula
  desc "Local AI agent with a long-term memory brain"
  homepage "https://github.com/ldclabs/anda-bot"
  version "0.9.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.2/anda-macos-arm64", using: :nounzip
      sha256 "129225681ece37e607ee0f524d6ad31fc3111057ad4469c24c245c414d02936d"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.2/anda-macos-x86_64", using: :nounzip
      sha256 "8361a3e31283ad0944bb79323c4af8a8881aa3b605b2082dab35117a714969ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.2/anda-linux-arm64", using: :nounzip
      sha256 "1a2286bb139d4eeacca448c4157d8070aaf0f13c2be57b323503fa8903990739"
    else
      url "https://github.com/ldclabs/anda-bot/releases/download/v0.9.2/anda-linux-x86_64", using: :nounzip
      sha256 "4e3a269334d26e618642d8ec24e126e5a7a5e1aee4046253508297e5e0e3800b"
    end
  end

  def install
    binary = Dir["anda-*"].first
    chmod 0755, binary
    bin.install binary => "anda"
  end

  def caveats
    <<~EOS
      Homebrew does not write runtime files into ~/.anda during install.
      To install or refresh curated skills, run:
        anda update --skills
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anda --version")
  end
end
