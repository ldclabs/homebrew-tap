class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.7/cbor-macos-arm64", using: :nounzip
      sha256 "2825fbc8cb384d6fbc3f5815c64388dcb5b21f6d458bd59ae04b2ec130e688be"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.7/cbor-macos-x86_64", using: :nounzip
      sha256 "f3ac5c1e1694b28bf5af73a71f4e6fd517a47ffc51bd09275be2c6837f48f39b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.7/cbor-linux-arm64", using: :nounzip
      sha256 "b9f50082e07a81fb4b9dcdd6eebcada2d8d0c6b4d55f1bfb3c22fe6d4a71ff65"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.7/cbor-linux-x86_64", using: :nounzip
      sha256 "3fa3f1b5a2069964bd7750b1c76d0fa2a56fbb9d1830cc3ebf76edd72f4465bc"
    end
  end

  def install
    binary = Dir["cbor-*"].first
    chmod 0755, binary
    bin.install binary => "cbor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbor --version")
    assert_match "{1: 2}", shell_output("#{bin}/cbor a10102")
  end
end
