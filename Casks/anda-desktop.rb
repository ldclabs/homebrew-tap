cask "anda-desktop" do
  version "0.14.8"
  sha256 "4223c9f5f53dc4fa11172ad34e88d9750f61ed5916436597659843716b50e105"

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
