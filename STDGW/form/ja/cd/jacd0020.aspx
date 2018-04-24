<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Genuwin</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{   
    OnSearch();
   grdCaddy.SetComboFormat(3, '#10;Avalable|#20;Bussy|#30;Day off');
   grdCaddy.SetComboFormat(4, '#MALE;Male|#FEMALE;Female');
   grdCaddy.SetComboFormat(6, '#10;Gold|#20;Silver|#30;Bronze');
}
//-----------------------------------------------------------------------------------------
function OnClick()
{      
   
   imgItem.SetDataText(grdCaddy.GetGridData(event.row, 8));
     flag='search';
   
}
//-----------------------------------------------------------------------------------------
function OnSearch()
{
    dso_jacd0020.Call('SELECT');
}


//-----------------------------------------------------------------------------------------
function OnRece(obj)
{
    switch (obj.id)
    {
        case 'dso_jacd0020_1':
            imgItem.SetDataText(txtImg.text );
            
        break;
    }
}
//-----------------------------------------------------------------------------------------

</script>

<body>
 <gw:data id="dso_jacd0020" > 
    <xml> 
        <dso id="1" type="grid" function="crm.sp_sel_jacd0020 " > 
            <input  >
                <input bind="txtCaddy"/>
               
                
            </input>
            <output bind="grdCaddy" /> 
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------->
<gw:data id="dso_jacd0020_1"  onreceive="OnRece(this)"> 
    <xml> 
        <dso id="2" type="control" function="crm.sp_sel_jacd0020_1" > 
            <input  >
                <input bind="txtCaddy_pk"/>
            </input>
            <output bind="txtImg" /> 
        </dso> 
    </xml> 
</gw:data>
    <table style="width:100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                
                    <td style="width:75%" >
                            
                                    <table width="100%">
                                    
                                            <tr style="width:100%">
                                                <td width="100%">
                                                    <fieldset>
                                                        <table width="100%">
                                                                <tr width="100%">
                                                                        <td width="8%" align="right">Caddy&nbsp;</td>
                                                                        <td width="52%"><gw:textbox id="txtCaddy" onenterkey="OnSearch()" styles="width: 100%" /></td>
                                                                        <td><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                                                                        <td width="40%"></td>
                                                                </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr style="width:100%">
                                                <td width="100%">
                                                         <gw:grid id="grdCaddy" header='_pk|Caddy No|Caddy Name|Status|Gender|Age|_LastRanking|Description|_photo_pk'
                                                            format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|1|0|0|0' defaults='||||||||'
                                                            editcol='0|0|0|0|0|0|0|0|0' widths='0|900|2500|1500|800|500|1500|2500|0'
                                                            sorting='T'  styles="width:100%;height:400" 
                                                            oncellclick="OnClick()"  />
                                                </td>
                                            </tr>
                                    </table>
                           
                    </td>
                    <td style="width:25%;background:white">
                        <table style="width:100%;height:100%">
                                <tr style="height:25%">
                                        <td>
                                                <gw:image id="imgItem" table_name="TCM_PHOTO" oid="0" view="/binary/ViewFile.aspx"
                                                post="/binary/PostFile.aspx" styles="width:99%;height:150" style='border: 1px solid #1379AC' />
                                        </td>
                                </tr>
                                
                               
                        </table>
                        
                    </td>
                   
            </tr>
            
    </table>
     <gw:textbox id="txtCaddy_pk" styles="display:none" />
     <gw:textbox id="txtImg" styles="display:none" />
</body>
</html>
