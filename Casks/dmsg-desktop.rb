cask "dmsg-desktop" do
  version "1.0.1"
  sha256 "5405a88e8ff740144200aba4a6d5bada9ba40d491c03b933b9616cb2b6bdf521"

  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v#{version}/dMsg-mac-arm64.dmg"
  name "dMsg"
  desc "Desktop workspace and approvals for dMsg"
  homepage "https://dmsg.net/"

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "dmsg"
  depends_on :macos

  app "dMsg.app"

  # The formula's dmsg owns the daemon and its login registration; ~/.dmsg
  # holds the vault and stays.
  zap trash: [
    "~/Library/Application Support/dMsg",
    "~/Library/Logs/dMsg",
    "~/Library/Preferences/net.dmsg.desktop.plist",
    "~/Library/Saved Application State/net.dmsg.desktop.savedState",
  ]
end
