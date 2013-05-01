/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.socraticgrid.documenttransformer;

import java.util.HashMap;

/**
 *
 * @author Jerry Goodnough
 */
public class TransformStep {

    private HashMap<String,Object> styleSheetParameters=null;
    
    public TransformStep() {
    }
 
    private String styleSheet="";
    public void  setStyleSheetParameters(HashMap<String,Object> params)
    {
        this.styleSheetParameters=params;
    }
    
    public HashMap<String,Object> getStyleSheetParameters()
    {
        return styleSheetParameters;
    }
    
    /**
     * Get the value of styleSheet
     *
     * @return the value of styleSheet
     */
    public String getStyleSheet() {
        return styleSheet;
    }

    /**
     * Set the value of styleSheet
     *
     * @param styleSheet new value of styleSheet
     */
    public void setStyleSheet(String styleSheet) {
        this.styleSheet = styleSheet;
    }

    //TODO: Add parameter support
}
