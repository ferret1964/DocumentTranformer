/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.socraticgrid.documenttransformer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;

import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;

/**
 *
 * @author Jerry Goodnough
 */
public class XSLTTransformStep implements org.springframework.context.ApplicationContextAware, TransformStep
{

    private ApplicationContext appCtx;
    private HashMap<String, Object> styleSheetParameters = null;
    private Transformer tx;
    private static TransformerFactory tfactory = TransformerFactory.newInstance();

    public XSLTTransformStep()
    {
    }

    public void setApplicationContext(ApplicationContext appCtx)
    {
        this.appCtx = appCtx;
    }
    private String styleSheet = "";

    public void setStyleSheetParameters(HashMap<String, Object> params)
    {
        this.styleSheetParameters = params;
    }

    public HashMap<String, Object> getStyleSheetParameters()
    {
        return styleSheetParameters;
    }

    /**
     * Get the value of styleSheet
     *
     * @return the value of styleSheet
     */
    public String getStyleSheet()
    {
        return styleSheet;
    }

    /**
     * Set the value of styleSheet
     *
     * @param styleSheet new value of styleSheet
     */
    public void setStyleSheet(String styleSheet)
    {
        this.styleSheet = styleSheet;
    }

    public void transform(StreamSource src, StreamResult result) throws TransformerException
    {
        tx.transform(src, result);
        if (Logger.getLogger(Transformer.class.getName()).isLoggable(Level.FINEST));
        {

            Logger.getLogger(Transformer.class.getName()).log(Level.FINEST, result.toString());
        }

    }

    @PostConstruct
    public void initialize()
    {
        Logger.getLogger(Transformer.class.getName()).log(Level.FINER, "Initialize Called");
        Resource resource = appCtx.getResource(this.styleSheet);
        if (resource == null)
        {
            Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, "Failed to find {0}", this.styleSheet);
        }
        else
        {

            String txFact = System.getProperty("javax.xml.transform.TransformerFactory");


            try
            {
                System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");


                tx = tfactory.newTransformer(new StreamSource(resource.getInputStream()));
                if (styleSheetParameters != null)
                {
                    Iterator<String> keyItr = styleSheetParameters.keySet().iterator();
                    while (keyItr.hasNext())
                    {
                        String key = keyItr.next();
                        tx.setParameter(key, styleSheetParameters.get(key));
                    }
                }
            }
            catch (IOException ex)
            {
                Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, null, ex);
            }
            catch (TransformerConfigurationException ex)
            {
                Logger.getLogger(XSLTTransformStep.class.getName()).log(Level.SEVERE, null, ex);
            }
            finally
            {
                if (txFact == null)
                {
                    System.clearProperty("javax.xml.transform.TransformerFactory");
                }
                else
                {
                    System.setProperty("javax.xml.transform.TransformerFactory", txFact);
                }

            }
        }

    }
}
