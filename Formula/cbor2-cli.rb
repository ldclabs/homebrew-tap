class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.4"
  license any_of: ["MIT", "Unlicense"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.4/cbor-macos-arm64", using: :nounzip
      sha256 "7475fda714c534f9cf42393b6ea802b1032839963c28f8a29e96f992bbbe5fc1"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.4/cbor-macos-x86_64", using: :nounzip
      sha256 "8d90a92f5137f732fdcb0bafdcfa6529426789f91d97cc2961c484f37f81569e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.4/cbor-linux-arm64", using: :nounzip
      sha256 "de793698b268f9351e605cc5134c2d3edfa5b4a5b755a26e9a92347de08de27e"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.4/cbor-linux-x86_64", using: :nounzip
      sha256 "a8847883eedc03c509a52f49b3be339574f5ad9dc8479c41549b84ec8e09ce46"
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
