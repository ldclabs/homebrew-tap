class Cbor2Cli < Formula
  desc "CBOR command-line converter and diagnostic notation inspector"
  homepage "https://github.com/ldclabs/cbor2"
  version "1.0.3"
  license any_of: ["MIT", "Unlicense"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.3/cbor-macos-arm64", using: :nounzip
      sha256 "feeef96094000821fa6ffd4427f8999607dd814480fa4e496e57a6ed5a41b807"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.3/cbor-macos-x86_64", using: :nounzip
      sha256 "9e45a240a1c0a25bdb334e25bfc54ebbfc96033d84832eefb5de71ee28d21167"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.3/cbor-linux-arm64", using: :nounzip
      sha256 "5cf85f525299c326a071517e8de40a17418be63a580eb3700d24f41bcca082a0"
    else
      url "https://github.com/ldclabs/cbor2/releases/download/v1.0.3/cbor-linux-x86_64", using: :nounzip
      sha256 "1fe41023b091ed32307bdbff794f81e0384b24243dbb82413a6b7faa02f25d5b"
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
