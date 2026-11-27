cask "anda-desktop" do
  version "0.16.1"
  sha256 "3dae9bb8fb78a3fc3f032d25a3866a42ee94145f27229c0269841bc9f79fedf7"

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
