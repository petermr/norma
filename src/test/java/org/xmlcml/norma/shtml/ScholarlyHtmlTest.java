package org.xmlcml.norma.shtml;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.xmlcml.cproject.args.DefaultArgProcessor;
import org.xmlcml.cproject.util.CMineTestFixtures;
import org.xmlcml.norma.NormaArgProcessor;
import org.xmlcml.norma.NormaFixtures;

import junit.framework.Assert;

/** transforms XML to html
 * Primitive, not yet scholarly.
 * 
 * @author pm286
 *
 */
public class ScholarlyHtmlTest {

	private static final Logger LOG = Logger.getLogger(ScholarlyHtmlTest.class);
	static {
		LOG.setLevel(Level.DEBUG);
	}

	@Test
	public void testScholarlyProject() throws IOException {
		File ursus = new File(NormaFixtures.TEST_NORMA_DIR, "shtml/ursus");
		File targetDir = new File("target/shtml/");
		CMineTestFixtures.cleanAndCopyDir(ursus, targetDir);
		DefaultArgProcessor normaArgProcessor = new NormaArgProcessor();
		String args = "--project "+targetDir.toString()+ " -i fulltext.xml  --transform nlm2html -o scholarly.html";
		LOG.trace(args);
		normaArgProcessor.parseArgs(args);
		normaArgProcessor.runAndOutput();
		List<File> outputFiles = Arrays.asList(targetDir.listFiles());
		LOG.debug(outputFiles);
		Assert.assertEquals(7, outputFiles.size());
		File pmc4422521 = new File("target/shtml/PMC4422521/scholarly.html");
		Assert.assertTrue(pmc4422521.exists());
		
	}
	
}
