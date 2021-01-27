const fs = require("fs");
const webdriver = require("selenium-webdriver");
const { Driver, Options } = require("selenium-webdriver/safari");
const util = require("util");

(async () => {
  console.log(util.inspect(Driver.createSession(new Options().setTechnologyPreview(true))));
  /*await driver.get("https://wasm-feature-detect.surma.technology");
  fs.writeFileSync(
    "screenshot.png",
    Buffer.from(await driver.takeScreenshot(), "base64")
  );*/
})();
