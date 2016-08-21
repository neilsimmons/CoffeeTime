GlobalConfig = {
LocalWifiSsid = "CoffeeTimer1", --ssid of the AP created by the node as yet unused
LocalWifiPassword = "TimerCoffee1", --password of the AP created by the node as yet unused
WifiSsid = "abc", --ssid of the wifi to connect to
WifiPassword = "def", --password of the wifi to connect to
EmailAddress = "123@gmail.com", --email address to send from
EmailPassword = "abc", --password to auth smtp with
SmtpServer = "smtp.gmail.com", --smtp server address ip unless you have dns
SmtpPort = "465", --port to connect to smtp on (secure)
EmailRecipientList = "coffeeloverstestemail@gmail.com" --comma seperated list of recipients
}
timers = {
Coffee = 1,
Flash = 2,
OneLightFlash = 5,
ButtonDebounce = 6
}
