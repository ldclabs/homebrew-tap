cask "anda-desktop" do
  version "0.14.5"
  sha256 "68a1aff828dcb381c4d515a10404a3c3313ca058b8a576e88029d320ffbafda0"

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
