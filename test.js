const fs = require("fs");
const webdriver = require("selenium-webdriver");
const { Driver, Options } = require("selenium-webdriver/safari");
const util = require("util");

(async () => {
  const options = new Options()
    .setTechnologyPreview(true)
    .setBrowserName("Safari Technology Preview");
  const driver = Driver.createSession(options);
  await driver.get("https://wasm-feature-detect.surma.technology");
  fs.writeFileSync(
    "screenshot.png",
    Buffer.from(await driver.takeScreenshot(), "base64")
  );
})();
