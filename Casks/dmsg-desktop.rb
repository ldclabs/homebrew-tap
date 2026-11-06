cask "dmsg-desktop" do
  version "1.4.0"
  sha256 "39aa16390c5fe72bde714c411467d31f057da73063e358a2ca19c3352f51eb8d"

  url "https://github.com/ldclabs/ic-panda/releases/download/#{version}/dMsg-mac-arm64.dmg"
  name "dMsg"
  desc "Desktop workspace and approvals for dMsg"
  homepage "https://dmsg.net/"

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
