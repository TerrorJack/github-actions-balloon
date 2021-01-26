const fs = require("fs");
const webdriver = require("selenium-webdriver");

(async () => {
  const driver = await new webdriver.Builder().forBrowser("safari").build();
  await driver.get("https://wasm-feature-detect.surma.technology");
  fs.writeFileSync(
    "screenshot.png",
    Buffer.from(await driver.takeScreenshot(), "base64")
  );
})();
