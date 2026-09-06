class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.5/cbor-macos-arm64", using: :nounzip
      sha256 "66e7f06f1b348dd50892636ed3c382bafa0f70e627b0a10812dc4ec20ea72fa5"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.5/cbor-macos-x86_64", using: :nounzip
      sha256 "80903d554fe8de74a5c4dae1b9433bf895eed16265f795925868fc52beaf322f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.5/cbor-linux-arm64", using: :nounzip
      sha256 "20b5ea6cf33e72ab152dae9283217fd10ec4bbc07dbab98b58c2fee8673c0f26"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.1.5/cbor-linux-x86_64", using: :nounzip
      sha256 "db01a0477a0448f2d1c6b5e81edae91af379ac5714cf165826e224f765a20d9c"
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
