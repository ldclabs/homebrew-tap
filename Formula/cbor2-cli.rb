class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.2.0/cbor-macos-arm64", using: :nounzip
      sha256 "09013e457194c1f1209b9564bc8f31efd12630b7a22e04a1aa4530ef730fce40"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.2.0/cbor-macos-x86_64", using: :nounzip
      sha256 "af168aeb490e455e1525883f8b1e7524ef462f13cced0c473e91cf6218810f80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.2.0/cbor-linux-arm64", using: :nounzip
      sha256 "89efaf7f78b40aa06c4d9ab812aca47e3df2afbe98a485f650d6de0ec5f0be6c"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.2.0/cbor-linux-x86_64", using: :nounzip
      sha256 "89e153c30943ad071133fe60b960406c18709bd6dcb33fd0503250aab2394e4b"
    end
  end

  def install
    binary = Dir["cbor-*"].first
    chmod 0755, binary
    bin.install binary => "cbor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbor --version")
    assert_match(/\{\s+1: 2\s+\}/, shell_output("#{bin}/cbor a10102"))
  end
end
