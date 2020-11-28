package examples.employees;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import static org.junit.Assert.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

@KarateOptions(tags = { "@employees" })
public class KarateRunner {

//  To run via Maven command use the 2 commands below: Command #1 to run the test. Command #2 to generate the HTML report in target/generated-report folder
//	mvn clean test -Dtest=KarateRunner -Dkarate.options="--tags @employees
//	mvn cluecumber-report:reporting
	
	@Test
	public void testParallel() {
		String karateOutputPath = "target/surefire-reports";
		Results results = Runner.parallel(getClass(), 5, karateOutputPath);
		generateReport(results.getReportDir());
		assertTrue("There are scenario failures --\n" + results.getErrorMessages(), results.getFailCount() == 0);
	}
	public static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"},true);
		List<String> jsonPaths = new ArrayList(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"), "Demo Project");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

}