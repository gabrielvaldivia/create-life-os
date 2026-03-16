#!/usr/bin/env node

const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const dirName = process.argv[2] || "life-os";
const targetDir = path.resolve(process.cwd(), dirName);

// Check if directory already exists and isn't empty
if (fs.existsSync(targetDir)) {
  const contents = fs.readdirSync(targetDir);
  if (contents.length > 0) {
    console.error(`\n  Error: ${dirName}/ already exists and isn't empty.\n`);
    process.exit(1);
  }
}

// Copy template files
const templateDir = path.join(__dirname, "..", "template");
fs.cpSync(templateDir, targetDir, { recursive: true });

// Rename gitignore to .gitignore (npm strips dotfiles from packages)
const gitignoreSrc = path.join(targetDir, "gitignore");
const gitignoreDest = path.join(targetDir, ".gitignore");
if (fs.existsSync(gitignoreSrc)) {
  fs.renameSync(gitignoreSrc, gitignoreDest);
}

// Rename claude-dir to .claude (npm strips dot-directories from packages)
const claudeDirSrc = path.join(targetDir, "claude-dir");
const claudeDirDest = path.join(targetDir, ".claude");
if (fs.existsSync(claudeDirSrc)) {
  fs.renameSync(claudeDirSrc, claudeDirDest);
}

// Init git
try {
  execSync("git init", { cwd: targetDir, stdio: "ignore" });
} catch {
  // git not available, skip
}

console.log(`
  Life OS created in ${dirName}/

  Next steps:

    cd ${dirName}
    claude
    > /setup

`);
