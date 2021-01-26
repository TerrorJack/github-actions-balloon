const webdriver = require("selenium-webdriver");

(async () => {
  let driver = await new webdriver.Builder().forBrowser("safari").build();
  console.log(driver);
})();
