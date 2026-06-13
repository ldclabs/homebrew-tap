class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.2"
  license any_of: ["MIT", "Unlicense"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.2/cbor-macos-arm64", using: :nounzip
      sha256 "abb41eabde24d4ef698674dfa3ee20941c15c55c19fc6c9678e0b286eeb741cd"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.2/cbor-macos-x86_64", using: :nounzip
      sha256 "a7b6307415516a28a8de79a09e32e04e92077d1273f6e54f4f634794f74acc1b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.2/cbor-linux-arm64", using: :nounzip
      sha256 "b9f72e8f09638a51beb5580284a62d9f8d051b84a02cc230e1f8b6d6cf24c1da"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.2/cbor-linux-x86_64", using: :nounzip
      sha256 "86190626cd5331c76ef772c0a0ecd69f429abff32fb2f11b970ebc037d484e02"
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
