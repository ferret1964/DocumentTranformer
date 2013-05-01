/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.socraticgrid.documenttransformer;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;

/**
 *
 * @author Jerry Goodnough
 */

public class TransformPipeline implements org.springframework.context.ApplicationContextAware
{


    private ApplicationContext appCtx;
    
    private List<TransformStep> transformChain=null;
    
    private LinkedList<Transformer> transformCache = null;
    
    private TransformerFactory tfactory = TransformerFactory.newInstance();
    
    //TODO: Decouple and move to a resource lookup bean in the future.
    public TransformPipeline()
    {
        
    }
  
    public void setApplicationContext(ApplicationContext appCtx){
        this.appCtx=appCtx;
    }
    

    //Factory
    public void setTransformChain(List<TransformStep> transformChain)
    {
        this.transformChain=transformChain;
    }
    
    public String transform(InputStream inStr)
    {
   
        StreamResult  result=null;
        ByteArrayOutputStream resultStream=null; 
        LinkedList<Transformer> xformChain = getCompiledTransformChain();
        if (xformChain != null)
        {
  
            Iterator<Transformer> itr = xformChain.iterator();
            Source src = new StreamSource(inStr);
            while(itr.hasNext())
            {
                Transformer tx = itr.next();
                //FUTURE: Provide Parameterz
                
                resultStream = new ByteArrayOutputStream();
                result=new StreamResult(resultStream);
                try
                {
                    tx.transform(src, result);
                    if (Logger.getLogger(Transformer.class.getName()).isLoggable(Level.FINEST));
                    {
                       
                        Logger.getLogger(Transformer.class.getName()).log(Level.FINEST,result.toString());
                    }
                }
                catch (TransformerException ex)
                {
                    Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (itr.hasNext())
                {
                    //Prepare the next source
                    ByteArrayInputStream bs = new ByteArrayInputStream(resultStream.toByteArray());
                    src = new StreamSource(bs);
                }
            }
        }
        else
        {
            //Invalid pipeline name
        }
        return resultStream.toString();
    }

    private LinkedList<Transformer> getCompiledTransformChain()
    {
        LinkedList<Transformer> out = null;
        if (transformCache!=null)
        {
            out = transformCache;
        }
        else
        {
            out = new LinkedList<Transformer>();
            Iterator<TransformStep> itr = transformChain.iterator();
            while (itr.hasNext())
            {
                TransformStep step = itr.next();
                try
                {
                    out.add(setupTransformStep(step));
                }
                catch (TransformerConfigurationException ex)
                {
                    Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, null, ex);
                    out = null;
                    break;
                }
            }
            transformCache=out;
        }
        return out;
    }

    private Transformer setupTransformStep(TransformStep step) throws TransformerConfigurationException
    {
        Resource resource =  appCtx.getResource(step.getStyleSheet());
        if (resource == null)
        {
               Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, "Failed to find {0}", step.getStyleSheet());
               throw new TransformerConfigurationException( "Failed to find "+step.getStyleSheet());
        }
        
        Transformer transformer=null;
        try
        {
            transformer = tfactory.newTransformer(new StreamSource(resource.getInputStream()));
            if (step.getStyleSheetParameters()!=null)
            {
                HashMap<String,Object> map = step.getStyleSheetParameters();
                Iterator<String> keyItr = map.keySet().iterator();
                while(keyItr.hasNext())
                {
                    String key = keyItr.next();
                    transformer.setParameter(key, map.get(key));
                }
            }
        }
        catch (IOException ex)
        {
            Logger.getLogger(Transformer.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        return transformer;
    }   
}
