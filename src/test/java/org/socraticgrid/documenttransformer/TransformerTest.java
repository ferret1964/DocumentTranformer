/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.socraticgrid.documenttransformer;

import java.io.InputStream;
import java.util.HashMap;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import org.junit.runner.RunWith;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 *
 * @author Jerry Goodnough
 */
@RunWith(SpringJUnit4ClassRunner.class)
// ApplicationContext will be loaded from "/applicationContext.xml" and "/applicationContext-test.xml"
// in the root of the classpath
@ContextConfiguration(locations={"classpath:Test-BaseDocumentTransformer.xml"})
public class TransformerTest extends TestCase
{
   @Autowired 
   private Transformer instance;

    public TransformerTest()
    {
        super();
    }
    public static junit.framework.Test suite()
    {
        TestSuite suite = new TestSuite(TransformStepTest.class);
        return suite;
    }
    /**
     * Test of setTransformPipeline method, of class Transformer.
     */
    
    public void testSetTransformPipeline()
    {
        System.out.println("setTransformPipeline");
        HashMap<String, TransformPipeline> transformPipeline = null;
        instance.setTransformPipeline(transformPipeline);
     
    }

    /**
     * Test of transform method, of class Transformer.
     */
    @Test
    public void testTransform() throws Exception
    {
        System.out.println("transform");
        String pipeline = "Medications";
        Resource res = new ClassPathResource("PatientDataRequest_meds_10013.xml");
        InputStream inStr = res.getInputStream();
    
        String expResult = "";
        String result = instance.transform(pipeline, inStr);
    
        assertTrue(result.length()>0);
    
    }
}
