const fs = require("fs");
const path = require("path");

const inputFolder = "../assets/language";
const outputFolder = "../lib/core/constants/localization";
const outputFile = "local_keys.g.dart";
const outputParamFile = "local_keys_param.g.dart";

const inputFolderPath = path.join(__dirname, inputFolder);
const outputFilePath = path.join(__dirname, outputFolder, outputFile);
const outputParamFilePath = path.join(__dirname, outputFolder, outputParamFile);
const inputFiles = fs.readdirSync(inputFolderPath);
const inputFilePath = path.join(inputFolderPath, inputFiles[0]);
const inputJson = JSON.parse(fs.readFileSync(inputFilePath, "utf8"));

console.clear();
console.log("Generating Dart code...");

String.prototype.isMatch = function (s) {
  return this.match(s) !== null;
};

langCodeGenJs = function (json, prefix = "") {
  const constants = {};

  for (const key in json) {
    let firstUpperKey = key.charAt(0).toUpperCase() + key.slice(1);
    if (typeof json[key] === "object") {
      const nestedConstants = langCodeGenJs(json[key], prefix + firstUpperKey + ".");
      Object.assign(constants, nestedConstants);
    } else {
      let toKey = prefix ? prefix + firstUpperKey : firstUpperKey;
      toKey = toKey.charAt(0).toLowerCase() + toKey.slice(1);
      constants[toKey.replaceAll(".", "")] = { key: toKey, value: json[key] };
    }
  }

  return constants;
};

const constants = langCodeGenJs(inputJson);

const dartCode =
  "// GENERATED CODE - DO NOT MODIFY BY HAND\n\n" +
  "// ignore: unused_import\n" +
  `import '${outputParamFile}';\n\n` +
  "final class LocalKeys {\n" +
  "\tLocalKeys._();\n\n" +
  Object.keys(constants)
    .map(key => {
      const args = [...constants[key].value.matchAll(/{([^}]*)}/g)];
      if (args.length > 0) {
        return (
          `\tstatic LocalKeysParam ${key}({\n` +
          args
            .map((arg, index) => {
              return `\t\trequired String arg${index},`;
            })
            .join("\n") +
          `\n\t}) {\n` +
          `\t\treturn LocalKeysParam(\n` +
          `\t\t\tkey: '${constants[key].key}',\n` +
          `\t\t\targs: <String>[` +
          `${args
            .map((arg, index) => {
              return `arg${index}`;
            })
            .join(", ")}` +
          `],\n` +
          `\t\t);\n` +
          `\t}`
        );
      }
      return `\tstatic String get ${key} => '${constants[key].key}';`;
    })
    .join("\n\n") +
  "\n}";

const paramDartCode =
  "// GENERATED CODE - DO NOT MODIFY BY HAND\n\n" +
  "final class LocalKeysParam {\n" +
  "\tconst LocalKeysParam({\n" +
  "\t\trequired this.key,\n" +
  "\t\trequired this.args,\n" +
  "\t});\n\n" +
  "\tfinal String key;\n" +
  "\tfinal List<String> args;\n" +
  "}";

fs.writeFileSync(outputFilePath, dartCode);
fs.writeFileSync(outputParamFilePath, paramDartCode);

console.log("Dart code generated successfully");
console.log("Output file: " + outputFilePath);
