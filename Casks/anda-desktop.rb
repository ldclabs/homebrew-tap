cask "anda-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.13.0"
  sha256 arm:   "f06dcf20aa2c8477b3fa5f18e7563ffbe77171401683fd135af9921f62b710af",
         intel: "e95d56ca09f94187b52baf0363576ab375bbcd7a3bf3ef3537f1dd9e94b27e71"

  url "https://github.com/ldclabs/anda-bot/releases/download/v#{version}/Anda-mac-#{arch}.dmg"
  name "Anda"
  desc "Desktop workspace and tray for the Anda local AI agent"
  homepage "https://anda.bot/"

  auto_updates true
  depends_on formula: "anda"
  depends_on :macos

  app "Anda.app"

  zap trash: [
    "~/Library/Application Support/Anda",
    "~/Library/Preferences/org.ldclabs.anda.desktop.plist",
  ]
end
