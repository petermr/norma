package org.xmlcml.norma.tagger;

import java.util.List;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.eclipse.jetty.util.log.Log;
import org.junit.Assert;
import org.junit.Test;
import org.xmlcml.norma.Norma;
import org.xmlcml.norma.NormaArgProcessor;
import org.xmlcml.norma.NormaFixtures;

/** Taggers not yet written
 * 
 * @author pm286
 *
 */
public class SectionTaggerTest {

	private static final Logger LOG = Logger.getLogger(SectionTaggerTest.class);
	static {
		LOG.setLevel(Level.DEBUG);
	}

	/** iterates over two taggers.
	 * 
	 */
	@Test
	public void testSectionTagger() {
		Norma norma = new Norma();
		norma.run("-i "+NormaFixtures.F0113556_XML+" -o target/tagger/f0113556 --ctree ");
		
		String cTree = "target/tagger/f0113556/src_test_resources_org_xmlcml_norma_pubstyle_plosone_journal_pone_0113556_fulltext_xml";
		String cmd = "-i fulltext.xml --ctree "+cTree+" -o scholarly.html --transform nlm2html --tag foo bar";
		norma = new Norma();
		norma.run(cmd);
		List<SectionTaggerX> taggers = ((NormaArgProcessor)norma.getArgProcessor()).getSectionTaggers();
		Assert.assertEquals("taggers", 2, taggers.size());
		LOG.debug(taggers.get(0));
		LOG.debug(taggers.get(1));
	}
}

