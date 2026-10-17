cask "anda-desktop" do
  version "0.14.4"
  sha256 "c2d959b85890cc0ed6c2b35e0579d1bb03a2e9932b8f5365105024a851019c82"

  url "https://github.com/ldclabs/anda-bot/releases/download/v#{version}/Anda-mac-arm64.dmg"
  name "Anda"
  desc "Desktop workspace and tray for the Anda local AI agent"
  homepage "https://anda.bot/"

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "anda"
  depends_on :macos

  app "Anda.app"

  zap trash: [
    "~/Library/Application Support/Anda",
    "~/Library/Preferences/org.ldclabs.anda.desktop.plist",
  ]
end
