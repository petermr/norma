package org.xmlcml.norma.table;

import java.io.File;
import java.io.FileOutputStream;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.xmlcml.graphics.html.HtmlElement;
import org.xmlcml.graphics.html.HtmlFooter;
import org.xmlcml.graphics.html.HtmlHeader;
import org.xmlcml.graphics.html.HtmlTitle;
import org.xmlcml.graphics.svg.text.structure.TextStructurer;
import org.xmlcml.svg2xml.table.TableContentCreator;
import org.xmlcml.xml.XMLUtil;

import com.gargoylesoftware.htmlunit.html.HtmlBody;

public class SVGTable2HTMLConverter {
	private static final Logger LOG = Logger.getLogger(SVGTable2HTMLConverter.class);

	static {
		LOG.setLevel(Level.DEBUG);
	}

	private File inputFile;
	private File outputFile;
	private TableContentCreator tableContentCreator;
	private File outputDir;
	private HtmlBody bodyElement;
	public HtmlTitle titleElement;
	private HtmlHeader headerElement;
	private HtmlFooter footerElement;
	private TextStructurer textStructurer;
	private HtmlElement outputHtmlElement;

	public SVGTable2HTMLConverter() {
		tableContentCreator = new TableContentCreator(); 
	}

	public void readInput(File inputFile) {
		this.inputFile = inputFile;
	}
	
	public void setOutputDir(File outputDir) {
		this.outputDir = outputDir;
	}
	
	public HtmlElement convert()  {
		getOrCreateOutputDir();
		tableContentCreator.markupAndOutputTable(inputFile, outputDir);
		textStructurer = tableContentCreator.getTableTextStructurer();
		tableContentCreator.annotateAreasInSVGChunk();
		outputHtmlElement = tableContentCreator.createHtmlFromSVG();
		try {
			XMLUtil.debug(outputHtmlElement, new FileOutputStream("target/junk.html"), 1);
		} catch (Exception e) {
			throw new RuntimeException("e", e);
		}
		
		return outputHtmlElement;
		
	}

	private void getOrCreateOutputDir() {
		if (outputDir == null && inputFile != null) {
			outputDir = inputFile.getParentFile();
		}
	}

	public HtmlBody getBodyElement() {
		return bodyElement;
	}

	public HtmlTitle getTitleElement() {
		return titleElement;
	}

	public HtmlHeader getHeaderElement() {
		return headerElement;
	}

	public HtmlFooter getFooterElement() {
		return footerElement;
	}
}
