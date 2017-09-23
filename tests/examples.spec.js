const fs = require('fs');
const path = require('path');
const spawn = require('cross-spawn');
const expect = require('unexpected');
const elmAppCmd = require.resolve('create-elm-app/bin/elm-app-cli.js');

const exampleDirs = [
  '1-1-starting-up-with-your-first-elm-app',
  '1-2-expressing-the-model-with-primitive-built-in-data-types',
  '1-3-expressing-the-model-with-built-in-data-types',
  '1-4-persistent-data-structures-in-elm',
  '1-5-elms-type-system-and-type-inference',
  '1-6-maybe-and-result-data-types',
  '1-7-module-system-in-elm',
  '1-8-rendering-the-model-with-html-and-css',
  '2-1-introducing-side-effects-with-beginner-program',
  '2-2-tasks-for-asynchronous-computations',
  '2-3-executing-the-program-with-commands',
  '2-4-manage-the-initial-application-state-with-program-with-flags',
  '2-5-communication-with-the-server',
  '2-6-encoding-and-decoding-json',
  '2-7-talking-to-javascript',
  '3-1-development-tools-elm-format-time-traveling-debugger-and-elm-reactor',
  '3-2-package-manager-and-open-source-packages',
  '3-3-testing-your-modules',
  '3-4-type-safe-css-with-elm-css',
  '4-1-encapsulation-and-code-organization',
  '4-2-managing-the-messages-with-tagger',
  '4-3-rendering-performance-optimizations-with-html-lazy'
].filter(dirName => fs.existsSync(path.join(process.cwd(), dirName, 'elm-package.json')));

describe('Examples of Elm applications', () => {
  exampleDirs.forEach(dirName => {
    it(`should compile example ${dirName}`, () => {
      const {status} = spawn.sync('node', [elmAppCmd, 'build'], {cwd: path.join(process.cwd(), dirName)});
      expect(status, 'to be', 0);
    }).timeout(20000);
  });

  it(`should pass tests in example 3-3`, () => {
    const {status} = spawn.sync('node', [elmAppCmd, 'test'], {cwd: path.join(process.cwd(), '3-3-testing-your-modules')});
    expect(status, 'to be', 0);
  }).timeout(20000);
});
