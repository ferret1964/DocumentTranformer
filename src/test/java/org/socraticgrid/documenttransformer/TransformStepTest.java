/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.socraticgrid.documenttransformer;

import java.util.HashMap;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 *
 * @author Jerry Goodnough
 */
public class TransformStepTest extends TestCase
{
    
    public TransformStepTest(String testName)
    {
        super(testName);
    }

    public static Test suite()
    {
        TestSuite suite = new TestSuite(TransformStepTest.class);
        return suite;
    }
    
    @Override
    protected void setUp() throws Exception
    {
        super.setUp();
    }
    
    @Override
    protected void tearDown() throws Exception
    {
        super.tearDown();
    }

    /**
     * Test of setStyleSheetParameters method, of class TransformStep.
     */
    public void testSetStyleSheetParameters()
    {
        System.out.println("setStyleSheetParameters");
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("Test", "testValue");
        TransformStep instance = new TransformStep();
        instance.setStyleSheetParameters(params);
        assertEquals(instance.getStyleSheetParameters(),params);

    }

    /**
     * Test of getStyleSheetParameters method, of class TransformStep.
     */
    public void testGetStyleSheetParameters()
    {
        System.out.println("getStyleSheetParameters");
        TransformStep instance = new TransformStep();
        HashMap expResult = null;
        //Should default to Null
        HashMap result = instance.getStyleSheetParameters();
        assertEquals(expResult, result);
    }

    /**
     * Test of getStyleSheet method, of class TransformStep.
     */
    public void testGetStyleSheet()
    {
        System.out.println("getStyleSheet");
        TransformStep instance = new TransformStep();
        String expResult = "";
        String result = instance.getStyleSheet();
        assertEquals(expResult, result);
       
    }

    /**
     * Test of setStyleSheet method, of class TransformStep.
     */
    public void testSetStyleSheet()
    {
        System.out.println("setStyleSheet");
        String styleSheet = "classpath:resource/xml-to-json.xsl";
        TransformStep instance = new TransformStep();
        instance.setStyleSheet(styleSheet);
        assertEquals(instance.getStyleSheet(),styleSheet);
    }
}
