class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.3/cbor-macos-arm64", using: :nounzip
      sha256 "004cc7efd954a2ecdb976512cc71959452e7b25703dc3f8c461167f7aa643590"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.3/cbor-macos-x86_64", using: :nounzip
      sha256 "ea414939c8af7d2cba43208ddb4b7eb47487b113a6460c6537cc47845da6dc5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.3/cbor-linux-arm64", using: :nounzip
      sha256 "14c86d8f6d3b9b6ea5fa75fc861736fa4e3afbd8764375ac510b1ba62e8cf902"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.3/cbor-linux-x86_64", using: :nounzip
      sha256 "13bde50a3cfb75e7fe591879bde2d25728abc77003b0435339ae09176b496166"
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
