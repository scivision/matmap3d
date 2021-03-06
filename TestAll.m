% this script is run on Azure (or local)

import matlab.unittest.TestRunner;
import matlab.unittest.Verbosity;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.codecoverage.CoberturaFormat;

name = "matmap3d";

suite = testsuite(name);

mkdir('code-coverage');
mkdir('test-results');

runner = TestRunner.withTextOutput();
runner.addPlugin(XMLPlugin.producingJUnitFormat('test-results/results.xml'));
runner.addPlugin(CodeCoveragePlugin.forPackage(name, 'Producing', CoberturaFormat('code-coverage/coverage.xml')));

results = runner.run(suite);
assert(~isempty(results), "no tests found")

assertSuccess(results)
