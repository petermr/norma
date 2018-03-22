package org.xmlcml.norma.demos.jenny;

import java.io.File;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.xmlcml.cproject.util.CMineTestFixtures;
import org.xmlcml.graphics.AbstractCMElement;
import org.xmlcml.graphics.svg.SVGElement;
import org.xmlcml.graphics.svg.SVGSVG;
import org.xmlcml.graphics.svg.cache.DocumentCache;
import org.xmlcml.norma.NormaFixtures;
import org.xmlcml.norma.NormaRunner;

public class MosquitoTest {
	private static final Logger LOG = Logger.getLogger(MosquitoTest.class);
	static {
		LOG.setLevel(Level.DEBUG);
	}

	@Test
	/** creates a corpus of 10 papers about mosquitos.
	 * mainly BMC (from Jenny Molloy)
	 * initially creates both original and compact SVG forms
	 * we have copied the compact form back to the demo directory
	 */
	@Ignore // too long
	public void testCreateCorpus() {
		File target = new File("target/demo/mosquitos/");
		Assert.assertTrue(NormaFixtures.MOSQUITOS_DIR.exists());
		CMineTestFixtures.cleanAndCopyDir(NormaFixtures.MOSQUITOS_DIR, target);
		new NormaRunner().convertRawPDFToProjectToCompactSVG(target);
		Assert.assertTrue(target.listFiles().length > 15);

	}

	@Test
	@Ignore // dupliacte filename
	public void testAnalyzeCorpus() {
		File target = new File("target/demo/mosquitos/");
		CMineTestFixtures.cleanAndCopyDir(NormaFixtures.MOSQUITOS_DIR, target);
		DocumentCache documentCache = new DocumentCache();
		AbstractCMElement documentSVG = documentCache.processSVGInCTreeDirectory(target);
		LOG.debug("DOC "+documentSVG.toXML());
		SVGSVG.wrapAndWriteAsSVG((SVGElement)documentSVG, new File("target/demo/mosquitos/document.svg"));
	}
}
