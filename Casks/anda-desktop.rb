cask "anda-desktop" do
  version "0.16.0"
  sha256 "c78e44d58811b34dbfbe7c45cfac90af8782c3c8449b131344fd99884a6d27d4"

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
