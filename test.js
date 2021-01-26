const fs = require("fs");
const webdriver = require("selenium-webdriver");
const { Options } = require("selenium-webdriver/safari");

(async () => {
  const driver = await new webdriver.Builder()
    .forBrowser("safari")
    .setSafariOptions(new Options().setTechnologyPreview(true))
    .build();
  await driver.get("https://wasm-feature-detect.surma.technology");
  fs.writeFileSync(
    "screenshot.png",
    Buffer.from(await driver.takeScreenshot(), "base64")
  );
})();
