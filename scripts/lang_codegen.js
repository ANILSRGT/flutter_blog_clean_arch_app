const fs = require("fs");
const path = require("path");

const inputFolder = "../assets/language";
const outputFolder = "../lib/core/constants/localization";
const outputFile = "local_keys.g.dart";

const inputFolderPath = path.join(__dirname, inputFolder);
const outputFilePath = path.join(__dirname, outputFolder, outputFile);
const inputFiles = fs.readdirSync(inputFolderPath);
const inputFilePath = path.join(inputFolderPath, inputFiles[0]);
const inputJson = JSON.parse(fs.readFileSync(inputFilePath, "utf8"));

const joinChar = ".";

console.clear();
console.log("Generating Dart code...");

String.prototype.isMatch = function (s) {
  return this.match(s) !== null;
};

langCodeGenJs = function (json, prefix = "") {
  const constants = {};

  for (const key in json) {
    if (typeof json[key] === "object") {
      const nestedConstants = langCodeGenJs(json[key], prefix + key + joinChar);
      Object.assign(constants, nestedConstants);
    } else {
      const toKey = prefix ? prefix + key : key;
      const constantKey = toKey
        .split(joinChar)
        .map((s, i) => (i === 0 ? s : s[0].toUpperCase() + s.slice(1)))
        .join("");
      constants[constantKey] = { key: toKey, value: json[key] };
    }
  }

  return constants;
};

const constants = langCodeGenJs(inputJson);

const dartCode =
  "// GENERATED CODE - DO NOT MODIFY BY HAND\n\n" +
  "final class LocalKeys {\n" +
  "\tLocalKeys._();\n\n" +
  Object.keys(constants)
    .map(key => {
      const args = [...constants[key].value.matchAll(/{([^}]*)}/g)];
      const argsCount = args.length;
      return `\tstatic String get ${key}${argsCount > 0 ? `Args$${argsCount}` : ""} => '${constants[key].key}';`;
    })
    .join("\n") +
  "\n}";

fs.writeFileSync(outputFilePath, dartCode);

console.log("Dart code generated successfully");
console.log("Output file: " + outputFilePath);
