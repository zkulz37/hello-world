<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("acnt")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<script>

var vnt_Click = true;
var vnt_RefreshNode = null;
var vnt_Change = true;
//var Insert      = 'T';
//var Modify      = 'T';
//var Delete    = 'T';
 function BodyInit()
 {   
    System.Translate(document);
    BindingDataList();
 }
function BindingDataList()
{   
    var ls_data      = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>"; 
    lst_TCO_COMPANY_PK.SetDataText(ls_data);
   
    OnSearch();
}
function OnSearch()    
{
    DSO_Sel_Tree_ABCenter.Call("SELECT");
}
function OnTreeClick()
{
//	DSO_Grid_Plcenter_List.StatusInsert();
	var obj = oTreePLC.GetCurrentNode();
	txt_PLC_PK.text = obj.oid;
	//vnt_Click = true;	
	DSO_Grid_Plcenter_List.Call("SELECT");
}
function OnEnter()
{	
	vnt_Click = false;
	DSO_Grid_Plcenter_List.Call("SELECT");
}

function OnSave()
{
        var i = 0;
        for(i = 1;i<idGridUse.rows;i++)
        {
            if(idGridUse.GetRowStatus(i)!=0x40)
            {
                    idGridUse.SetGridText(i,8,dtMonth.value);
            }
          
             
        }
    
    DSO_Grid_Plcenter_List.Call();
   
}
function OnDelete()
{
    if ( confirm( "Delete it?" ))
	{
		vnt_Click=false;
		idGridUse.DeleteRow();		
		
	}
}

//-------------------------------------- Tab : PL Center List ----------------------------------------
function OnSearch_List()
{
    DSO_Grid_PLC_List.Call("SELECT");
}
function Numbers(e)
{
     
    var keynum;
    var keychar;
    var numcheck;
    keynum =event.keyCode;
  
    if(window.event) // IE
     {
     	keynum = e.keyCode;
     }
    else if(e.which) // Netscape/Firefox/Opera
    {
    	keynum = e.which;
    }
    keychar = String.fromCharCode(keynum);
    numcheck = /\d/;
    return numcheck.test(keychar);
}


function OnDataReceive(p_oData)
{       
    
     if(p_oData.id == 'DSO_Grid_Plcenter_List')
     {
            
     }
}    
function OnpopUp(obj)
{
        switch(obj)
        {
                case 1:
                        if(idGridUse.col == '10')
                        {
                                var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lst_TCO_COMPANY_PK.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_ALL";
	                            var object = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes'); 
                                if ((object != null) &&(object[0]!="0"))
                                {
                                    idGridUse.SetGridText( idGridUse.row, 11, object[3]);    //ACPK
	                                idGridUse.SetGridText( idGridUse.row, 10, object[0]+' - '+object[1]);    //Account Code
                                }
                        }
                break;
                case 2:
                                if(event.col == 3)
                                {
                                       var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lst_TCO_COMPANY_PK.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                                            var object  = System.OpenModal(fpath , 600 , 400 , 'resizable:yes;status:yes');                     
                                            if ( object != null )  
                                            {         
//                                               txt_PL_PK.text = object[5];
//                                                   if(!CheckDuplicate())
//                                                   {
//                                                          return;
//                                                   }  
//                                                   else
//                                                   {
                                                           idGridUse.SetGridText( idGridUse.row , 1, object[5]);    //Center PK
                                                           idGridUse.SetGridText( idGridUse.row, 3, object[0]);    //Center Name
                                                           idGridUse.SetGridText( idGridUse.row, 4, object[1]); 
                                                           idGridUse.SetGridText( idGridUse.row, 12, object[2]); 
//                                                   }                                  
                                                   
                                            }
                                }
                break;
        }
}
//-----------------------------------------------------------------------------
function CheckDuplicate()
{
      for(var i = 1; i < idGridUse.rows; i++)
      {
          
          if(idGridUse.GetGridData(i, 1) == txt_PL_PK.text)
          {
              
               alert("Duplicated Cost Center!! ");
               return false ;
          }
         // txtac_pk.SetDataText(GridRight.GetGridData(GridRight.row,4));
      }
    return true;
}
//-------------------------------------------------------------------------
function OnNew()
{
    
    idGridUse.AddRow();
    idGridUse.SetGridText(idGridUse.rows -1 ,8, dtMonth.value);
    idGridUse.SetGridText(idGridUse.rows -1 ,2, txt_PLC_PK.text);
}
</script>
 
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0">

<gw:data id="DSO_Sel_Tree_ABCenter" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="tree" parameter="0,1,2" function="acnt.SP_SEL_ABCENTER_TREE">
                <input bind="oTreePLC" >
                    <input bind="lst_TCO_COMPANY_PK"/>
                    <input bind="txt_SPLC_CD"/>
                    <input bind="txt_SPLC_NM"/>
                </input>
                <output bind="oTreePLC" />
            </dso>
        </xml>
</gw:data>      



<gw:data id="DSO_Grid_Plcenter_List"  onreceive=""> 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="ACNT.SP_SEL_PLCL_INFO3" procedure="ACNT.SP_UPD_PLCL_INFO1">
            <input bind="idGridUse" >  
                <input bind="lst_TCO_COMPANY_PK" />
                <input bind="txt_PLC_PK" />
                <input bind="txt_PL_CD" />
                <input bind="txt_PL_NM" />   
                <input bind="dtMonth" />            
            </input>
            <output bind="idGridUse" />
        </dso>                    
    </xml>
</gw:data>


    
<!------------------------ Main Table -------------------------->    



<table align ="top" cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%;border-color:#6B9EB8;background-color:White">
<tr valign="top" style="width:100%">    
    <td style="width:30%" valign="top" >
    
        <table width="100%" align="top">
            <tr>
                    <td style="width:100%">
                            <fieldset style="width:100%">
                                    <table style="width:100%;height:100%">
                                         <tr>
                                            <td width="14%" align="right">Company</td>
                                            <td width="20%" align="left"  valign="top">
                                                <gw:list id="lst_TCO_COMPANY_PK" value="" styles="width:100%" onchange="OnSearch()" ></gw:list></td>
                                        </tr>
                                        <tr>
                                            <td width="13%" align="right">Biz. Center Code</td>
                                            <td width="20%" align="left"  valign="top">
                                                <gw:textbox id="txt_SPLC_CD"  text=""  styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" /></td>
                                        </tr>
                                        <tr>
                                            <td width="13%" align="right">Biz. Center Name</td>
                                            <td width="20%" align="left"  valign="top"><gw:textbox id="txt_SPLC_NM"  text=""  styles="width:100%" csstype="mandatory" onenterkey="OnSearch()"/></td>
                                        </tr>   
                                    </table>
                            </fieldset>
                    </td>
            </tr>
            
            <tr>
                <td colspan=2><gw:tree  id="oTreePLC" style="width:100%;height:400;overflow:auto" onclicknode="OnTreeClick()" ></gw:tree></td>
            </tr>
        </table>
    </td>
    
    <td style="width:70%;height:100%" valign="top" >
        <table style="width:100%;height:100%" border=0 cellpadding="0" cellspacing="0">
            <tr valign="top" style="width:100%;height:5%">
            
                <td>
                    <fieldset>
                      <table style="width:100%">
                        <tr style="width:100%">
                            <td width="27%" align="right">Cost Center Code </td>
	                        <td width="15%" align="left"><gw:textbox id="txt_PL_CD"  text=""  styles="width:100%" onenterkey="OnEnter()"/></td>
	                        <td width="28%" align="right">Cost Center Name </td>
	                        <td width="20%" align="left"><gw:textbox id="txt_PL_NM"  text=""  styles="width:100%" onenterkey="OnEnter()"/></td>
	                        <td width="10%"><gw:datebox id="dtMonth" styles="width:100%"  lang="<%=Session("Lang")%>" onchange="OnEnter()" type="month"/></td>
                            <td ><gw:imgBtn img="new"       alt="Save1"    id="idBtnUpdate1" 	styles="width:100%" onclick="OnNew()" /></td>
                            <td ><gw:imgBtn img="save"       alt="Save"    id="idBtnUpdate" 	styles="width:100%" onclick="OnSave()" /></td>
                            <td ><gw:imgBtn img="delete"     alt="Delete"  id="idBtnDelete" 	styles="width:100%" onclick="OnDelete()" /></td> 
                        </tr>    
                       
                                                              
                    </table>
                    </fieldset>
                   
                </td>
            </tr>
             <tr style="width:100%;height:95%">
                            <td >		            
                                <gw:grid   
                                    id="idGridUse"  
                                    header   = "_PK|_ABPL_PK|_ABCENTER_PK|Cost Center Code|Cost Center Name|Remark|_Biz. Center Code|_Biz. Center Name|Month|Employee Quantity|Account Name|_acc_pk|_tac_abplcenter_pk"
                                    format   = "0|0|0|0|0|0|0|0|0|0|0|0|0"
                                    aligns   = "0|0|0|0|0|0|0|0|1|3|0|0|0"
                                    defaults = "||||||||||||"
                                    editcol  = "0|0|0|0|0|1|0|0|1|1|1|0|0"   
                                    widths   = "0|0|0|2000|2000|2500|1500|2500|800|1800|3500|0|0"
                                    styles   = "width:100%; height:100%"   
                                    sorting  = "T"
                                    oncelldblclick = "OnpopUp(1);OnpopUp(2)"
                                     /> 
                            </td>
            </tr>           
           
        </table>
        
    </td>
</tr>    
</table>



    <gw:textbox id="txt_PLC_PK"                 style="display:none"/>
    <gw:textbox id="txt_PLC_P_PK"               style="display:none"/>
    <gw:textbox id="txt_Temp_PLC_P_PK"          style="display:none"/>
    <gw:textbox id="txt_Temp_Dept_PK"           style="display:none"/>  
    <gw:textbox id="txt_Temp_PLC_P_CD"          style="display:none"/>  
    
    <gw:textbox id="txt_CheckCode"                  style="display:none"/> 
    <gw:textbox id="txt_CheckName"                  style="display:none"/> 
    <gw:textbox id="txt_CheckChild"                 style="display:none"/>  
  <gw:textbox id="txt_PL_PK"                 style="display:none"/>
</body>

</html>