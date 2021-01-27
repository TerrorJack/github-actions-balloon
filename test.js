const fs = require("fs");
const { Driver, Options } = require("selenium-webdriver/safari");
const util = require("util");

(async () => {
  const options = new Options()
    .setTechnologyPreview(true)
    .setBrowserName("Safari Technology Preview");
  const driver = Driver.createSession(options);
  console.log(await driver.getCapabilities());
  await driver.get("https://httpbin.org/anything");
  console.log(await driver.getPageSource());
  await driver.get("https://wasm-feature-detect.surma.technology");
  fs.writeFileSync(
    "screenshot.png",
    Buffer.from(await driver.takeScreenshot(), "base64")
  );
})();
